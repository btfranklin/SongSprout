//  Created by B.T. Franklin on 12/24/19.

import AudioKit

struct ArpeggiatorPartComposer {
       
    private let identifier: PartIdentifier = .arpeggiator
    private let channel: PartChannel = .arpeggiator

    private let section: Section
    private let song: Song
    private let partGenotype: ArpeggiatorPartGenotype
    private let velocity: MIDIVelocity
    
    init(for section: Section, in song: Song, using partGenotype: ArpeggiatorPartGenotype) {
        self.section = section
        self.song = song
        self.partGenotype = partGenotype
        self.velocity = 100
    }
    
    func composeNormal() -> ComposedPartSection {
        
        var midiNoteData: [MIDINoteData] = []
        
        let noteDuration = Duration(beats: partGenotype.noteDurationOptions.randomElement()!)
        let sequenceLength = partGenotype.sequenceLengthOptions.randomElement()!
        
        let phraseData: [MIDINoteData]
        if partGenotype.followsChords {
            phraseData = composeNormalPhraseFollowingChords(partGenotype.octave, sequenceLength, noteDuration)
        } else {
            phraseData = composeNormalPhraseNotFollowingChords(partGenotype.octave, sequenceLength, noteDuration)
        }
        
        for phraseNumber in 0..<section.descriptor.phraseCount {
            let phraseOffset = Duration(beats: Double(phraseNumber) * section.descriptor.phraseDuration.beats)
            
            for phraseMIDINoteDatum in phraseData {
                midiNoteData.append(.init(noteNumber: phraseMIDINoteDatum.noteNumber,
                                          velocity: phraseMIDINoteDatum.velocity,
                                          channel: phraseMIDINoteDatum.channel,
                                          duration: phraseMIDINoteDatum.duration,
                                          position: phraseMIDINoteDatum.position + phraseOffset))
            }
        }
        
        
        return ComposedPartSection(partIdentifier: identifier, section: section, midiNoteData: midiNoteData)
    }
    
    private func composeNormalPhraseFollowingChords(_ octave: Int, _ sequenceLength: Int, _ noteDuration: Duration) -> [MIDINoteData] {
        
        var midiNoteData: [MIDINoteData] = []
        
        var firstChord: Chord?
        for chordIndex in 0..<section.chordProgression.chordDescriptors.count {
            
            let chordDescriptor = section.chordProgression.chordDescriptors[chordIndex]
            let chordPlacement = section.chordPlacementMapPerPhrase.chordPlacements[chordIndex]
            
            let chord: Chord
            if let firstChord {
                chord = firstChord.findClosestInversion(using: chordDescriptor)
            } else {
                chord = Chord(from: chordDescriptor, octave: octave)
                firstChord = chord
            }
            
            let pitchSequence = createPitchSequence(from: chord,
                                                    withCount: sequenceLength,
                                                    usingOrderingStyle: partGenotype.pitchOrderingStyle)
            
            let endOfChordPosition = chordPlacement.position + chordPlacement.duration
            var position = chordPlacement.position
            var pitchIndex = 0
            while position < endOfChordPosition {
                
                let pitch = pitchSequence[pitchIndex]
                pitchIndex += 1
                if pitchIndex == pitchSequence.count {
                    pitchIndex = 0
                }
                
                midiNoteData.append(.init(noteNumber: pitch.midiNoteNumber,
                                          velocity: self.velocity,
                                          channel: channel.rawValue,
                                          duration: noteDuration,
                                          position: position))
                
                position += noteDuration
            }
        }
        
        return midiNoteData
    }
    
    private func composeNormalPhraseNotFollowingChords(_ octave: Int, _ sequenceLength: Int, _ noteDuration: Duration) -> [MIDINoteData] {
        
        var midiNoteData: [MIDINoteData] = []
        
        let chord = Chord(from: .init(scale: song.scale, rootScaleDegree: 0, components: [0,2,4,7]), octave: octave)
        
        let pitchSequence = createPitchSequence(from: chord,
                                                withCount: sequenceLength,
                                                usingOrderingStyle: partGenotype.pitchOrderingStyle)
        
        var position = Duration(beats: 0)
        var pitchIndex = 0
        while position < section.descriptor.phraseDuration {
            
            let pitch = pitchSequence[pitchIndex]
            pitchIndex += 1
            if pitchIndex == pitchSequence.count {
                pitchIndex = 0
            }
            
            midiNoteData.append(.init(noteNumber: pitch.midiNoteNumber,
                                      velocity: self.velocity,
                                      channel: channel.rawValue,
                                      duration: noteDuration,
                                      position: position))
            
            position += noteDuration
        }
        
        return midiNoteData
    }
    
    private func createPitchSequence(from chord: Chord, withCount pitchCount: Int, usingOrderingStyle pitchOrderingStyle: ArpeggioPitchOrderingStyle) -> [Pitch] {
        var pitchSequence: [Pitch] = []
        
        let chordPitches: [Pitch]
        
        switch pitchOrderingStyle {
        case .ascending, .rootAlternatingAscending:
            chordPitches = chord.pitches.sorted { pitch1, pitch2 in
                pitch1.midiNoteNumber < pitch2.midiNoteNumber
            }
        case .descending, .rootAlternatingDescending:
            chordPitches = chord.pitches.sorted { pitch1, pitch2 in
                pitch1.midiNoteNumber > pitch2.midiNoteNumber
            }
        case .random:
            chordPitches = chord.pitches.shuffled()
        }
        
        if pitchOrderingStyle == .rootAlternatingAscending || pitchOrderingStyle == .rootAlternatingDescending {
            pitchSequence.append(chordPitches[0])
        }
        
        var pitchIndex = 0
        var octaveShift = 0
        while pitchSequence.count < pitchCount {
            
            var pitch = chordPitches[pitchIndex].octaveShifted(by: octaveShift)
            if pitchOrderingStyle == .rootAlternatingAscending || pitchOrderingStyle == .rootAlternatingDescending {
                if pitch == chordPitches[0] {
                    pitchIndex += 1
                    pitch = chordPitches[pitchIndex].octaveShifted(by: octaveShift)
                }
            }
            pitchSequence.append(pitch)
            
            pitchIndex += 1
            if pitchIndex == chordPitches.count {
                pitchIndex = 0
                switch pitchOrderingStyle {
                case .ascending, .rootAlternatingAscending:
                    octaveShift += 1
                case .descending, .rootAlternatingDescending:
                    octaveShift -= 1
                case .random:
                    break
                }
            }
            
            if pitchOrderingStyle == .rootAlternatingAscending || pitchOrderingStyle == .rootAlternatingDescending {
                if pitchSequence.count < pitchCount {
                    pitchSequence.append(chordPitches[0])
                }
            }
        }

        return pitchSequence
    }
}
