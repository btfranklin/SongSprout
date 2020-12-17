//  Created by B.T. Franklin on 12/22/19.

import AudioKit

struct PadPartComposer {
    
    private let identifier: PartIdentifier = .pad
    private let channel: PartChannel = .pad

    private let section: Section
    private let song: Song
    private let partGenotype: PadPartGenotype
    private let velocity: MIDIVelocity
    
    init(for section: Section, in song: Song, using partGenotype: PadPartGenotype) {
        self.section = section
        self.song = song
        self.partGenotype = partGenotype
        self.velocity = 100
    }
    
    func composeNormal() -> ComposedPartSection {
        var midiNoteData = [MIDINoteData]()
        
        let phraseData = composeNormalPhrase()
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
    
    // TODO un-private this and make it real
    private func composeIntro() -> ComposedPartSection {
        var midiNoteData = [MIDINoteData]()
        
        for phraseNumber in 0..<section.descriptor.phraseCount {
            
            let phraseOffset = Duration(beats: Double(phraseNumber) * section.descriptor.phraseDuration.beats)
            
            var firstChord: Chord?
            for chordIndex in 0..<section.chordProgression.chordDescriptors.count {
                
                let chordDescriptor = section.chordProgression.chordDescriptors[chordIndex]
                let chordPlacement = section.chordPlacementMapPerPhrase.chordPlacements[chordIndex]
                
                let chord: Chord
                if let firstChord = firstChord {
                    chord = firstChord.findClosestInversion(using: chordDescriptor)
                    
                } else {
                    chord = Chord(from: chordDescriptor, octave: partGenotype.octave)
                    firstChord = chord
                }
                
                midiNoteData.append(.init(noteNumber: chord.pitches[0].midiNoteNumber,
                                          velocity: self.velocity,
                                          channel: channel.rawValue,
                                          duration: chordPlacement.duration,
                                          position: chordPlacement.position + phraseOffset))
            }
        }

        return ComposedPartSection(partIdentifier: identifier, section: section, midiNoteData: midiNoteData)
    }

    func composeFinale() -> ComposedPartSection {
        var midiNoteData = [MIDINoteData]()
        
        let chordDescriptor = section.chordProgression.chordDescriptors.first!
        let chordPlacement = section.chordPlacementMapPerPhrase.chordPlacements.first!
        
        let chord = Chord(from: chordDescriptor, octave: partGenotype.octave)
        
        for pitch in chord.pitches {
            midiNoteData.append(.init(noteNumber: pitch.midiNoteNumber,
                                      velocity: self.velocity,
                                      channel: channel.rawValue,
                                      duration: chordPlacement.duration,
                                      position: chordPlacement.position))
        }
        
        return ComposedPartSection(partIdentifier: identifier, section: section, midiNoteData: midiNoteData)
    }
    
    private func composeNormalPhrase() -> [MIDINoteData] {
        var midiNoteData = [MIDINoteData]()
        
        var firstChord: Chord?
        for chordIndex in 0..<section.chordProgression.chordDescriptors.count {
            
            let chordDescriptor = section.chordProgression.chordDescriptors[chordIndex]
            let chordPlacement = section.chordPlacementMapPerPhrase.chordPlacements[chordIndex]
            
            let chord: Chord
            if let firstChord = firstChord {
                chord = firstChord.findClosestInversion(using: chordDescriptor)
            } else {
                chord = Chord(from: chordDescriptor, octave: partGenotype.octave)
                firstChord = chord
            }
            
            for pitch in chord.pitches {
                midiNoteData.append(.init(noteNumber: pitch.midiNoteNumber,
                                          velocity: self.velocity,
                                          channel: channel.rawValue,
                                          duration: chordPlacement.duration,
                                          position: chordPlacement.position))
            }
        }
        
        return midiNoteData
    }
    
}
