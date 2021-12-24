//  Created by B.T. Franklin on 5/4/20.

import AudioKit
import ControlledChaos

extension AccompanimentPartComposer {
    
    func composeNormalPhraseUsingArpeggioStyle() -> [MIDINoteData] {
        var midiNoteData: [MIDINoteData] = []
        
        for chordIndex in 0..<section.chordProgression.chordDescriptors.count {
            
            let chordDescriptor = section.chordProgression.chordDescriptors[chordIndex]
            let chordPlacement = section.chordPlacementMapPerPhrase.chordPlacements[chordIndex]
            let chord = Chord(from: chordDescriptor, octave: partGenotype.octave)
            let chordData = composeArpeggiatedChord(for: chord, withDuration: chordPlacement.duration)
            
            for chordMIDINoteDatum in chordData {
                midiNoteData.append(.init(noteNumber: chordMIDINoteDatum.noteNumber,
                                          velocity: chordMIDINoteDatum.velocity,
                                          channel: chordMIDINoteDatum.channel,
                                          duration: chordMIDINoteDatum.duration,
                                          position: chordMIDINoteDatum.position + chordPlacement.position))
            }
        }
        
        return midiNoteData
    }
    
    private func composeArpeggiatedChord(for chord: Chord, withDuration duration: Duration) -> [MIDINoteData] {
        var midiNoteData: [MIDINoteData] = []
        
        let isAccented = Bool.random(probability: partGenotype.accentProbability)
        
        enum PositionInCycle: Int {
            case one, two, three, four
            
            func next() -> PositionInCycle {
                if self == .four {
                    return .one
                } else {
                    return PositionInCycle(rawValue: self.rawValue+1)!
                }
            }
        }
        var positionInCycle = PositionInCycle.one
        for placementLocation in stride(from: 0, to: duration.beats, by: 1.0) {
            
            var pitches: [Pitch] = []
            switch positionInCycle {
            case .one:
                pitches.append(chord.pitches[0])
            case .two:
                pitches.append(chord.pitches[2])
            case .three:
                pitches.append(chord.pitches[0].octaveShifted(by: 1))
            case .four:
                pitches.append(chord.pitches[2])
            }
            
            for pitch in pitches {
                midiNoteData.append(.init(noteNumber: pitch.midiNoteNumber,
                                          velocity: (isAccented && positionInCycle == .one) ? self.accentedVelocity : self.defaultVelocity,
                                          channel: channel.rawValue,
                                          duration: .init(beats: 1.0),
                                          position: .init(beats: placementLocation)))
                
            }
            
            positionInCycle = positionInCycle.next()
        }
        
        return midiNoteData
    }
    
}
