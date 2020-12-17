//  Created by B.T. Franklin on 6/14/20.

import AudioKit

struct Fill {
    
    enum Style: String, CaseIterable {
        case silentGap
        case buildToSilentGap
        case snareRoll
        case tomRun
        case freeform
    }
    
    let midiNoteData: [MIDINoteData]
    
    init(for duration: Double,
         with complexity: Complexity,
         using partGenotype: DrumsPartGenotype,
         on channel: PartChannel,
         allowSilentGap: Bool) {
        
        var midiNoteData = [MIDINoteData]()
        
        let style: Style
        if allowSilentGap {
            style = Style.allCases.randomElement()!
        } else {
            let styleOptions: [Style] = [.snareRoll, .tomRun, .freeform]
            style = styleOptions.randomElement()!
        }

        let subdivisionDurationChangeProbability: Int
        switch complexity {
        case .negligible, .veryLow:
            subdivisionDurationChangeProbability = 0
        case .low:
            subdivisionDurationChangeProbability = 25
        case .medium:
            subdivisionDurationChangeProbability = 50
        case .high:
            subdivisionDurationChangeProbability = 75
        case .veryHigh:
            subdivisionDurationChangeProbability = 100
        }
        
        let includeHihatPedal = Bool.random()
        let includeBassDrum = Bool.random()
        let hihatPedalInterval = Bool.random() ? 1.0 : 0.5
        let bassDrumInterval = Bool.random() ? 1.0 : 0.5
        
        switch style {
        case .silentGap:
            // nothing to do...just leave the note data empty
            break
            
        case .buildToSilentGap:
            let buildDuration: Double

            switch duration {
            case 1.0:
                buildDuration = 0.0
            case 2.0:
                buildDuration = 1.0
            default:
                buildDuration = duration - 2.0
            }
            
            if buildDuration > 0 {
                let buildFill = Fill(for: buildDuration,
                                     with: complexity,
                                     using: partGenotype,
                                     on: channel,
                                     allowSilentGap: false)
                midiNoteData = buildFill.midiNoteData
            }

        case .snareRoll:
            let gapCountPerMeasure: Double
            switch complexity {
            case .negligible, .veryLow:
                gapCountPerMeasure = 0
            case .low:
                gapCountPerMeasure = Bool.random() ? 1 : 0
            case .medium:
                gapCountPerMeasure = [0, 1, 2].randomElement()!
            case .high:
                gapCountPerMeasure = [1, 2, 3].randomElement()!
            case .veryHigh:
                gapCountPerMeasure = [2, 3, 4].randomElement()!
            }
            let gapCount = Int((duration / SectionDescriptor.MEASURE_DURATION.beats) * gapCountPerMeasure)

            var currentSubdivisionDuration = Bool.random() ? 0.5 : 0.25
            var positionCursor = 0.0
            while positionCursor < duration {
                midiNoteData.append(.init(noteNumber: partGenotype.snareDrumGenotype.preset.rawValue,
                                          velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                          channel: channel.rawValue,
                                          duration: .init(beats: 1),
                                          position: .init(beats: positionCursor)))
                
                if includeHihatPedal && positionCursor.remainder(dividingBy: hihatPedalInterval) == 0 {
                    midiNoteData.append(.init(noteNumber: PercussionNoteNumber.pedalHiHat.rawValue,
                                              velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                              channel: channel.rawValue,
                                              duration: .init(beats: hihatPedalInterval),
                                              position: .init(beats: positionCursor)))
                }
                
                if includeBassDrum && positionCursor.remainder(dividingBy: bassDrumInterval) == 0 {
                    midiNoteData.append(.init(noteNumber: partGenotype.bassDrumGenotype.preset.rawValue,
                                              velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                              channel: channel.rawValue,
                                              duration: .init(beats: bassDrumInterval),
                                              position: .init(beats: positionCursor)))
                }
                
                positionCursor += currentSubdivisionDuration
                
                if positionCursor == positionCursor.rounded() && Bool.random(probability: subdivisionDurationChangeProbability) {
                    currentSubdivisionDuration = Bool.random() ? 0.5 : 0.25
                }
            }
            
            for _ in 0..<gapCount {
                midiNoteData.remove(at: Int.random(in: 0..<midiNoteData.count))
            }

        case .tomRun:
            let drumOptions: [PercussionNoteNumber] = [
                partGenotype.snareDrumGenotype.preset,
                .highTom1,
                .highTom2,
                .midTom1,
                .midTom2,
                .lowTom1,
                .lowTom2,
            ]
            
            let drumLingerDuration = Bool.random() ? 1.0 : 0.5
            let numberOfDrumsInRun = duration / drumLingerDuration
            let drumOptionStepSize = Int( (Double(drumOptions.count) / numberOfDrumsInRun).rounded() )

            var currentDrumIndex = 0
            var timeOnCurrentDrum = 0.0
            var currentSubdivisionDuration = Bool.random() ? 0.5 : 0.25
            var positionCursor = 0.0
            while positionCursor < duration {
                if timeOnCurrentDrum > drumLingerDuration {
                    currentDrumIndex += drumOptionStepSize
                    if currentDrumIndex >= drumOptions.count {
                        currentDrumIndex = drumOptions.count - 1
                    }
                }
                
                midiNoteData.append(.init(noteNumber: drumOptions[currentDrumIndex].rawValue,
                                          velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                          channel: channel.rawValue,
                                          duration: .init(beats: 1),
                                          position: .init(beats: positionCursor)))
                
                if includeHihatPedal && positionCursor.remainder(dividingBy: hihatPedalInterval) == 0 {
                    midiNoteData.append(.init(noteNumber: PercussionNoteNumber.pedalHiHat.rawValue,
                                              velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                              channel: channel.rawValue,
                                              duration: .init(beats: hihatPedalInterval),
                                              position: .init(beats: positionCursor)))
                }
                
                if includeBassDrum && positionCursor.remainder(dividingBy: bassDrumInterval) == 0 {
                    midiNoteData.append(.init(noteNumber: partGenotype.bassDrumGenotype.preset.rawValue,
                                              velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                              channel: channel.rawValue,
                                              duration: .init(beats: bassDrumInterval),
                                              position: .init(beats: positionCursor)))
                }

                positionCursor += currentSubdivisionDuration
                timeOnCurrentDrum += currentSubdivisionDuration

                if positionCursor == positionCursor.rounded() && Bool.random(probability: subdivisionDurationChangeProbability) {
                    currentSubdivisionDuration = Bool.random() ? 0.5 : 0.25
                }
            }

        case .freeform:
            let drumOptions: [PercussionNoteNumber] = [
                partGenotype.snareDrumGenotype.preset,
                .highTom1,
                .highTom2,
                .midTom1,
                .midTom2,
                .lowTom1,
                .lowTom2,
                partGenotype.bassDrumGenotype.preset
            ]

            var currentDrum = drumOptions.randomElement()!
            var currentSubdivisionDuration = Bool.random() ? 0.5 : 0.25
            var positionCursor = 0.0
            while positionCursor < duration {
                midiNoteData.append(.init(noteNumber: currentDrum.rawValue,
                                          velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                          channel: channel.rawValue,
                                          duration: .init(beats: 1),
                                          position: .init(beats: positionCursor)))
                
                if includeHihatPedal && positionCursor.remainder(dividingBy: hihatPedalInterval) == 0 {
                    midiNoteData.append(.init(noteNumber: PercussionNoteNumber.pedalHiHat.rawValue,
                                              velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                              channel: channel.rawValue,
                                              duration: .init(beats: hihatPedalInterval),
                                              position: .init(beats: positionCursor)))
                }
                
                if currentDrum != partGenotype.bassDrumGenotype.preset && includeBassDrum && positionCursor.remainder(dividingBy: bassDrumInterval) == 0 {
                    midiNoteData.append(.init(noteNumber: partGenotype.bassDrumGenotype.preset.rawValue,
                                              velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                              channel: channel.rawValue,
                                              duration: .init(beats: bassDrumInterval),
                                              position: .init(beats: positionCursor)))
                }

                positionCursor += currentSubdivisionDuration
                if positionCursor.remainder(dividingBy: 0.5) == 0 {
                    currentDrum = drumOptions.randomElement()!
                }

                if positionCursor == positionCursor.rounded() && Bool.random(probability: subdivisionDurationChangeProbability) {
                    currentSubdivisionDuration = Bool.random() ? 0.5 : 0.25
                }
            }
        }
        
        self.midiNoteData = midiNoteData
    }
}
