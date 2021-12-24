//  Created by B.T. Franklin on 5/7/20.

import AudioKit
import ControlledChaos

extension AccompanimentPartComposer {
    
    private enum FreeformNoteDuration: Double, Codable {
        case sixteenthNote = 0.25
        case eighthNote = 0.5
        case quarterNote = 1.0
        case dottedQuarterNote = 1.5
        case halfNote = 2.0
        case dottedHalfNote = 3.0
        case wholeNote = 4.0
    }
    
    static private let noteDurationBeatProbabilities = ProbabilityGroup<FreeformNoteDuration>([
        .sixteenthNote      :  5,
        .eighthNote         : 10,
        .quarterNote        : 25,
        .dottedQuarterNote  : 20,
        .halfNote           : 25,
        .dottedHalfNote     : 10,
        .wholeNote          :  5
    ], enforcePercent: true)
    
    func composeNormalPhraseUsingFreeformStyle() -> [MIDINoteData] {
        var midiNoteData: [MIDINoteData] = []
        
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
            
            let chordData = composeNormalFreeformChord(for: chord, withDuration: chordPlacement.duration)
            
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
    
    private func composeNormalFreeformChord(for chord: Chord, withDuration duration: Duration) -> [MIDINoteData] {
        var midiNoteData: [MIDINoteData] = []

        var positionCursor = Duration(beats: 0)
        while positionCursor < duration {

            let remainingDuration = duration - positionCursor
            let firstNoteDurationBeats = AccompanimentPartComposer.noteDurationBeatProbabilities.randomItem()
            let noteDuration = min(remainingDuration, Duration(beats: firstNoteDurationBeats.rawValue))
            let isRest = Bool.random(probability: 5)
            if isRest {
                positionCursor += noteDuration
            } else {
                let isAccented = Bool.random(probability: partGenotype.accentProbability)
                
                switch firstNoteDurationBeats {
                case .sixteenthNote:
                    let startingPitch = chord.pitches.randomElement()!
                    let isMovingUpwards = Bool.random()
                    let scalePitches = song.scale.pitches(fromOctave: chord.pitches.first!.octave-1, toOctave: chord.pitches.first!.octave+1)
                    let beatsToFill = min(remainingDuration.beats, 1.0)
                    var currentPitch = startingPitch
                    for offset in stride(from: 0.0, to: beatsToFill, by: FreeformNoteDuration.sixteenthNote.rawValue) {
                        midiNoteData.append(.init(noteNumber: currentPitch.midiNoteNumber,
                                                  velocity: isAccented ? self.accentedVelocity : self.defaultVelocity,
                                                  channel: channel.rawValue,
                                                  duration: noteDuration,
                                                  position: positionCursor + .init(beats: offset)))
                        let currentPitchIndex = scalePitches.firstIndex(of: currentPitch)!

                        let proposedNewPitchIndex = currentPitchIndex + (isMovingUpwards ? 1 : -1)
                        let clampedNewPitchIndex = min(max(proposedNewPitchIndex, 0), scalePitches.count-1)
                        currentPitch = scalePitches[clampedNewPitchIndex]
                    }
                    positionCursor += .init(beats: beatsToFill)
                    
                case .eighthNote:
                    midiNoteData.append(.init(noteNumber: chord.pitches.randomElement()!.midiNoteNumber,
                                              velocity: isAccented ? self.accentedVelocity : self.defaultVelocity,
                                              channel: channel.rawValue,
                                              duration: noteDuration,
                                              position: positionCursor))
                    positionCursor += noteDuration
                    
                    if positionCursor < duration {
                        let remainingDuration = duration - positionCursor
                        let secondNoteDuration = min(remainingDuration, Duration(beats: FreeformNoteDuration.eighthNote.rawValue))
                        midiNoteData.append(.init(noteNumber: chord.pitches.randomElement()!.midiNoteNumber,
                                                  velocity: isAccented ? self.accentedVelocity : self.defaultVelocity,
                                                  channel: channel.rawValue,
                                                  duration: secondNoteDuration,
                                                  position: positionCursor))
                        positionCursor += secondNoteDuration
                    }
                    
                case .dottedQuarterNote:
                    let pitches = chord.pitches.shuffled()
                    for pitch in pitches {
                        let isFirstPitch = (pitches.first! == pitch)
                        if isFirstPitch || Bool.random(probability: partGenotype.freeformAdditionalChordNoteProbability) {
                            midiNoteData.append(.init(noteNumber: pitch.midiNoteNumber,
                                                      velocity: isAccented ? self.accentedVelocity : self.defaultVelocity,
                                                      channel: channel.rawValue,
                                                      duration: noteDuration,
                                                      position: positionCursor))
                        }
                    }
                    positionCursor += noteDuration
                    
                    if positionCursor < duration {
                        let remainingDuration = duration - positionCursor
                        let secondNoteDuration = min(remainingDuration, Duration(beats: FreeformNoteDuration.eighthNote.rawValue))
                        let pitches = chord.pitches.shuffled()
                        for pitch in pitches {
                            let isFirstPitch = (pitches.first! == pitch)
                            if isFirstPitch || Bool.random(probability: partGenotype.freeformAdditionalChordNoteProbability) {
                                midiNoteData.append(.init(noteNumber: pitch.midiNoteNumber,
                                                          velocity: isAccented ? self.accentedVelocity : self.defaultVelocity,
                                                          channel: channel.rawValue,
                                                          duration: secondNoteDuration,
                                                          position: positionCursor))
                            }
                        }
                        positionCursor += secondNoteDuration
                    }
                    
                default:
                    let pitches = chord.pitches.shuffled()
                    for pitch in pitches {
                        let isFirstPitch = (pitches.first! == pitch)
                        if isFirstPitch || Bool.random(probability: partGenotype.freeformAdditionalChordNoteProbability) {
                            midiNoteData.append(.init(noteNumber: pitch.midiNoteNumber,
                                                      velocity: isAccented ? self.accentedVelocity : self.defaultVelocity,
                                                      channel: channel.rawValue,
                                                      duration: noteDuration,
                                                      position: positionCursor))
                        }
                    }
                    positionCursor += noteDuration
                }
            }
        }

        return midiNoteData
    }
    
}
