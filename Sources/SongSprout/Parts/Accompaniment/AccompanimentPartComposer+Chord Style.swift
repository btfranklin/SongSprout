//  Created by B.T. Franklin on 5/3/20.

import AudioKit
import DunesailerUtilities

extension AccompanimentPartComposer {
    
    static private let firstNoteDurationProbabilities = ProbabilityGroup<Double>([
        1.0 : 30,
        1.5 : 25,
        2.0 : 25,
        3.0 : 10,
        4.0 : 10
    ], enforcePercent: true)

    func composeNormalPhraseUsingChordStyle() -> [MIDINoteData] {
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
            
            let chordData = composeNormalChord(for: chord, withDuration: chordPlacement.duration)
            
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
    
    private func composeNormalChord(for chord: Chord, withDuration duration: Duration) -> [MIDINoteData] {
        var midiNoteData = [MIDINoteData]()
        
        let isAccented = Bool.random(probability: partGenotype.accentProbability)
        
        var notePlacements = [(location: Duration, duration: Duration)]()
        var availableDuration = duration
        var placementCursor = Duration(beats: 0.0)
        while availableDuration.beats > 0 {
            
            var firstNoteDuration = Duration(beats: AccompanimentPartComposer.firstNoteDurationProbabilities.randomItem())
            if firstNoteDuration > availableDuration {
                firstNoteDuration = availableDuration
            }
            notePlacements.append((location: placementCursor, duration: firstNoteDuration))
            availableDuration -= firstNoteDuration
            placementCursor += firstNoteDuration
            
            // Dotted quarter note special case
            if firstNoteDuration.beats == 1.5 && availableDuration.beats > 0 {
                var secondNoteDuration = Duration(beats: 0.5)
                if secondNoteDuration > availableDuration {
                    secondNoteDuration = availableDuration
                }
                notePlacements.append((location: placementCursor, duration: secondNoteDuration))
                availableDuration -= secondNoteDuration
                placementCursor += secondNoteDuration
            }
            
        }
        
        for notePlacement in notePlacements {
            
            let pitches: [Pitch]
            if notePlacement.duration.beats <= 0.5 {
                pitches = chord.randomInversion().pitches
            } else {
                pitches = chord.pitches
            }
            
            for pitch in pitches {
                midiNoteData.append(.init(noteNumber: pitch.midiNoteNumber,
                                          velocity: isAccented ? self.accentedVelocity : self.defaultVelocity,
                                          channel: channel.rawValue,
                                          duration: notePlacement.duration,
                                          position: notePlacement.location))
                
            }
        }
        
        return midiNoteData
    }
    
}
