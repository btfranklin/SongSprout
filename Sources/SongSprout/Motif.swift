//  Created by B.T. Franklin on 2/18/20.

import DunesailerUtilities
import AudioKit

struct Motif {
    
    enum MotifDuration {
        case twoBeats
        case oneMeasure
        case twoMeasures
    }
    
    private enum MotifPitch: Int, CaseIterable {
        case rest = 0
        case belowChordFirstDegree
        case chordFirstDegree
        case betweenChordFirstAndThirdDegrees
        case chordThirdDegree
        case betweenChordThirdAndFifthDegrees
        case chordFifthDegree
        case aboveChordFifthDegree
    }
    
    private enum MovementDirection: CaseIterable {
        case up
        case same
        case down
    }
    
    private struct Note: Equatable {
        let pitch: MotifPitch
        let duration: Duration
    }
    
    private let restProbability = 25
    private let notes: [Note]
    
    let durationInBeats: Double
    
    init(duration: MotifDuration,
         complexity: Complexity) {
        
        switch duration {
        case .twoBeats:
            durationInBeats = 2.0
        case .oneMeasure:
            durationInBeats = SectionDescriptor.MEASURE_DURATION.beats
        case .twoMeasures:
            durationInBeats = SectionDescriptor.MEASURE_DURATION.beats * 2
        }
        
        var notes: [Note] = []
        var previousPitch: MotifPitch?
        let durations = Motif.split(duration: durationInBeats, for: complexity)
        for duration in durations {
            let pitch: MotifPitch
            if notes.isEmpty {
                switch Int.random(in: 0...100) {
                case 41...70:
                    pitch = .chordThirdDegree
                case 71...100:
                    pitch = .chordFifthDegree
                default:
                    pitch = .chordFirstDegree
                }
            } else {
                guard let previousPitch = previousPitch else {
                    fatalError("Previous pitch was not initialized")
                }
                
                let movementDirection = MovementDirection.allCases.randomElement()!

                if duration <= 0.25 {
                    if previousPitch == .rest {
                        switch movementDirection {
                        case .up:
                            pitch = .chordFifthDegree
                        case .same:
                            pitch = .chordThirdDegree
                        case .down:
                            pitch = .chordFirstDegree
                        }
                    } else {
                        let previousPitchValue = previousPitch.rawValue
                        var newPitchValue: Int
                        
                        if Bool.random(probability: restProbability) {
                            pitch = .rest
                        } else {
                            switch movementDirection {
                            case .up:
                                newPitchValue = previousPitchValue + 1
                            case .same:
                                newPitchValue = previousPitchValue
                            case .down:
                                newPitchValue = previousPitchValue - 1
                            }
                            
                            let highestPitchValue = MotifPitch.aboveChordFifthDegree.rawValue
                            let lowestPitchValue = MotifPitch.belowChordFirstDegree.rawValue
                            if newPitchValue < lowestPitchValue {
                                newPitchValue = highestPitchValue
                            } else if newPitchValue > highestPitchValue {
                                newPitchValue = lowestPitchValue
                            }
                            pitch = MotifPitch(rawValue: newPitchValue)!
                        }
                    }
                    
                } else {
                    let previousPitchValue = previousPitch.rawValue
                    if Bool.random(probability: restProbability) {
                        pitch = .rest
                    } else {
                        var newPitchValue: Int
                        switch movementDirection {
                        case .up:
                            if previousPitchValue < MotifPitch.chordThirdDegree.rawValue {
                                newPitchValue = MotifPitch.chordThirdDegree.rawValue
                            } else {
                                newPitchValue = MotifPitch.chordFifthDegree.rawValue
                            }
                                
                        case .same:
                            newPitchValue = previousPitchValue
                            
                        case .down:
                            if previousPitchValue > MotifPitch.chordThirdDegree.rawValue {
                                newPitchValue = MotifPitch.chordThirdDegree.rawValue
                            } else {
                                newPitchValue = MotifPitch.chordFirstDegree.rawValue
                            }
                        }
                        
                        pitch = MotifPitch(rawValue: newPitchValue)!
                    }
                }
                
            }
            
            notes.append(.init(pitch: pitch, duration: .init(beats: duration)))
            previousPitch = pitch
        }
        
        self.notes = notes
    }

    private init(durationInBeats: Double, notes: [Note]) {
        self.notes = notes
        self.durationInBeats = durationInBeats
    }
    
    func varied() -> Motif {
        var newNotes = self.notes
        let numberOfNotesToVary = (newNotes.count > 2 && Bool.random()) ? 2 : 1
        for _ in 1...numberOfNotesToVary {
            let indexToVary = Int.random(in: 0..<newNotes.count)
            while newNotes[indexToVary] == self.notes[indexToVary] {
                newNotes[indexToVary] = .init(pitch: MotifPitch.allCases.randomElement()!, duration: newNotes[indexToVary].duration)
            }
            
        }
        return .init(durationInBeats: self.durationInBeats, notes: newNotes)
    }
    
    private static func split(duration: Double, for complexity: Complexity) -> [Double] {
        var durations: [Double] = []
        
        let finalGranularity: Double
        switch complexity {
        case .negligible, .veryLow:
            finalGranularity = 2.0
        case .low, .medium:
            finalGranularity = 1.0
        case .high, .veryHigh:
            finalGranularity = 0.5
        }
        
        if duration == finalGranularity {
            durations.append(contentsOf: Bool.random() ? [finalGranularity] : [finalGranularity / 2, finalGranularity / 2])
        } else if duration > finalGranularity {
            durations.append(contentsOf: Motif.split(duration: duration / 2, for: complexity))
            durations.append(contentsOf: Motif.split(duration: duration / 2, for: complexity))
        } else {
            durations.append(duration)
        }
        
        return durations
    }
    
    func createMIDINoteData(in chord: Chord,
                                   on channel: PartChannel,
                                   with velocity: MIDIVelocity,
                                   using pitches: [Pitch]) -> [MIDINoteData] {
        var midiNoteData: [MIDINoteData] = []

        let chordPitchIndices = chord.pitches.map {pitch in
            pitches.firstIndex(of: pitch)
        }
        
        var placementCursor = Duration(beats: 0)
        for note in notes {
            let noteNumber: MIDINoteNumber?
            
            switch note.pitch {
            case .rest:
                noteNumber = nil
            case .belowChordFirstDegree:
                noteNumber = pitches[chordPitchIndices[0]!-1].midiNoteNumber
            case .chordFirstDegree:
                noteNumber = pitches[chordPitchIndices[0]!].midiNoteNumber
            case .betweenChordFirstAndThirdDegrees:
                noteNumber = pitches[chordPitchIndices[1]!-1].midiNoteNumber
            case .chordThirdDegree:
                noteNumber = pitches[chordPitchIndices[1]!].midiNoteNumber
            case .betweenChordThirdAndFifthDegrees:
                noteNumber = pitches[chordPitchIndices[2]!-1].midiNoteNumber
            case .chordFifthDegree:
                noteNumber = pitches[chordPitchIndices[2]!].midiNoteNumber
            case .aboveChordFifthDegree:
                noteNumber = pitches[chordPitchIndices[2]!+1].midiNoteNumber
            }
            
            if let noteNumber = noteNumber {
                midiNoteData.append(.init(noteNumber: noteNumber,
                                          velocity: velocity,
                                          channel: channel.rawValue,
                                          duration: note.duration,
                                          position: placementCursor))
            }
            placementCursor += note.duration
        }

        return midiNoteData
    }
}
