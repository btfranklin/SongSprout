//  Created by B.T. Franklin on 5/3/20.

import AudioKit
import ControlledChaos

extension AccompanimentPartComposer {
    
    func composeNormalPhraseUsingLongChordStyle() -> [MIDINoteData] {
        var midiNoteData: [MIDINoteData] = []
        
        for chordIndex in 0..<section.chordProgression.chordDescriptors.count {
            
            let chordDescriptor = section.chordProgression.chordDescriptors[chordIndex]
            let chordPlacement = section.chordPlacementMapPerPhrase.chordPlacements[chordIndex]
            let chord = Chord(from: chordDescriptor, octave: partGenotype.octave)
            let chordData = composeNormalLongChord(for: chord, withDuration: chordPlacement.duration)
            
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
    
    private func composeNormalLongChord(for chord: Chord, withDuration duration: Duration) -> [MIDINoteData] {
        var midiNoteData: [MIDINoteData] = []
        
        let isAccented = Bool.random(probability: partGenotype.accentProbability)
        
        let pitches: [Pitch]
        if duration.beats <= 1.0 {
            pitches = chord.randomInversion().pitches
        } else {
            pitches = chord.pitches
        }
        
        for pitch in pitches {
            midiNoteData.append(.init(noteNumber: pitch.midiNoteNumber,
                                      velocity: isAccented ? self.accentedVelocity : self.defaultVelocity,
                                      channel: channel.rawValue,
                                      duration: duration,
                                      position: .init(beats: 0)))
            
        }

        return midiNoteData
    }
    
}
