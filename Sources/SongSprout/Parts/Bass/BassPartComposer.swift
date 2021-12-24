//  Created by B.T. Franklin on 1/8/20.

import AudioKit
import ControlledChaos

struct BassPartComposer {
    
    private let identifier: PartIdentifier = .bass
    private let channel: PartChannel = .bass

    private let section: Section
    private let song: Song
    private let partGenotype: BassPartGenotype
    private let velocity: MIDIVelocity
    
    init(for section: Section, in song: Song, using partGenotype: BassPartGenotype) {
        self.section = section
        self.song = song
        self.partGenotype = partGenotype
        
        self.velocity = 100
    }
    
    func composeNormal() -> ComposedPartSection {
        var midiNoteData: [MIDINoteData] = []
        
        var composedDrumsPartSection: ComposedPartSection?
        if partGenotype.style == .triesToFollowDrums {
            if song.genotype.drumsPartGenotype != nil {
                composedDrumsPartSection = self.section.composedPartSections.first(where: {$0.partIdentifier == .drums})
            }
        }
        
        for phraseNumber in 0..<section.descriptor.phraseCount {
            let phraseOffset = Duration(beats: Double(phraseNumber) * section.descriptor.phraseDuration.beats)
            
            var phraseMidiNoteData: [MIDINoteData]
            
            switch partGenotype.style {
            case .triesToFollowDrums:
                if let composedDrumsPart = composedDrumsPartSection {
                    phraseMidiNoteData = composePhrase(following: composedDrumsPart)
                } else {
                    phraseMidiNoteData = composePhraseFollowingMotif()
                }
            case .followsChordChanges:
                phraseMidiNoteData = composePhraseFollowingChordChanges()
            case .followsMotif:
                phraseMidiNoteData = composePhraseFollowingMotif()
            }
            
            phraseMidiNoteData = phraseMidiNoteData.map {
                .init(noteNumber: $0.noteNumber,
                      velocity: $0.velocity,
                      channel: $0.channel,
                      duration: $0.duration,
                      position: $0.position + phraseOffset)
            }
            
            midiNoteData.append(contentsOf: phraseMidiNoteData)
        }
        
        return ComposedPartSection(partIdentifier: identifier,
                                   section: section,
                                   midiNoteData: midiNoteData)
    }

    func composeFinale() -> ComposedPartSection {
        var midiNoteData: [MIDINoteData] = []
        
        let chordDescriptor = section.chordProgression.chordDescriptors.first!
        let chordPlacement = section.chordPlacementMapPerPhrase.chordPlacements.first!
        
        let chord = Chord(from: chordDescriptor, octave: partGenotype.octave)
        
        let finalNoteBeats = [1.0, 2.0, SectionDescriptor.MEASURE_DURATION.beats].randomElement()!
        
        midiNoteData.append(.init(noteNumber: chord.root.midiNoteNumber,
                                  velocity: self.velocity,
                                  channel: channel.rawValue,
                                  duration: .init(beats: finalNoteBeats),
                                  position: chordPlacement.position))
        
        return ComposedPartSection(partIdentifier: identifier, section: section, midiNoteData: midiNoteData)
    }

    private func composePhrase(following composedDrumsPartSection: ComposedPartSection) -> [MIDINoteData] {
        var midiNoteData: [MIDINoteData] = []
        
        let drumsPartGenotype = song.genotype.drumsPartGenotype!
        let followSnare = Bool.random()
        
        // TODO: Investigate whether these positions match correctly
        var drumPositions: [Duration] = []
        for midiNoteDatum in composedDrumsPartSection.midiNoteData {
            if midiNoteDatum.noteNumber == drumsPartGenotype.bassDrumGenotype.preset.rawValue {
                drumPositions.append(midiNoteDatum.position)
            }
            if followSnare && midiNoteDatum.noteNumber == drumsPartGenotype.snareDrumGenotype.preset.rawValue {
                drumPositions.append(midiNoteDatum.position)
            }
        }
        
        for chordIndex in 0..<section.chordProgression.chordDescriptors.count {
            
            let chordDescriptor = section.chordProgression.chordDescriptors[chordIndex]
            let chordPlacement = section.chordPlacementMapPerPhrase.chordPlacements[chordIndex]
            let chord = Chord(from: chordDescriptor, octave: partGenotype.octave)
            let chordMidiNoteData = composeFollowingDrumsForChord(from: chordPlacement.position,
                                                                  to: chordPlacement.position + chordPlacement.duration,
                                                                  for: chord,
                                                                  following: drumPositions)
            
            midiNoteData.append(contentsOf: chordMidiNoteData)
        }
        
        return midiNoteData
    }
    
    private func composeFollowingDrumsForChord(from startPosition: Duration,
                                               to endPosition: Duration,
                                               for chord: Chord,
                                               following drumPositions: [Duration]) -> [MIDINoteData] {
        var midiNoteData: [MIDINoteData] = []
        
        var useLeadingNote = false
        for drumPosition in drumPositions {
            if (startPosition..<endPosition).contains(drumPosition) {
                let pitch: Pitch
                
                if (endPosition - drumPosition).beats < 2.0 && Bool.random(probability: partGenotype.leadingNoteProbability) {
                    useLeadingNote = true
                }
                
                if useLeadingNote {
                    pitch = chord.pitches.randomElement()!
                } else {
                    pitch = chord.pitches[0]
                }
                
                midiNoteData.append(.init(noteNumber: pitch.midiNoteNumber,
                                          velocity: self.velocity,
                                          channel: channel.rawValue,
                                          duration: .init(beats: 1),
                                          position: drumPosition))
            }
        }
        
        return midiNoteData
    }
    
    private func composePhraseFollowingChordChanges() -> [MIDINoteData] {
        var midiNoteData: [MIDINoteData] = []
        
        for chordIndex in 0..<section.chordProgression.chordDescriptors.count {
            let chordDescriptor = section.chordProgression.chordDescriptors[chordIndex]
            let chordPlacement = section.chordPlacementMapPerPhrase.chordPlacements[chordIndex]
            let chord = Chord(from: chordDescriptor, octave: partGenotype.octave)
            let pitch = chord.pitches[0]
            midiNoteData.append(.init(noteNumber: pitch.midiNoteNumber,
                                      velocity: self.velocity,
                                      channel: channel.rawValue,
                                      duration: chordPlacement.duration,
                                      position: chordPlacement.position))
        }
        
        return midiNoteData
    }
    
    private func composePhraseFollowingMotif() -> [MIDINoteData] {
        var midiNoteData: [MIDINoteData] = []
        
        for chordIndex in 0..<section.chordProgression.chordDescriptors.count {
            let chordDescriptor = section.chordProgression.chordDescriptors[chordIndex]
            let chordPlacement = section.chordPlacementMapPerPhrase.chordPlacements[chordIndex]
            let chord = Chord(from: chordDescriptor, octave: partGenotype.octave)
            let pitch = chord.pitches[0]
            midiNoteData.append(.init(noteNumber: pitch.midiNoteNumber,
                                      velocity: self.velocity,
                                      channel: channel.rawValue,
                                      duration: chordPlacement.duration,
                                      position: chordPlacement.position))
        }
        
        return midiNoteData
    }
    
}
