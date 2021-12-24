//  Created by B.T. Franklin on 1/12/20.

import ControlledChaos

public struct HihatRideSubPartGenotype: Codable {
    
    public enum HihatPedalMode: Int, CaseIterable, Codable {
        case none
        case beat
        case halfBeat
    }
    
    public let shortNoteMeasures: [[Double]]
    public let longNoteMeasures: [[Double]]
    public let hihatPedalMode: HihatPedalMode
    public let rideCymbalProbability: Int
    
    public init(shortNoteMeasures: [[Double]],
                longNoteMeasures: [[Double]],
                hihatPedalMode: HihatPedalMode,
                rideCymbalProbability: Int) {
        self.shortNoteMeasures = shortNoteMeasures
        self.longNoteMeasures = longNoteMeasures
        self.hihatPedalMode = hihatPedalMode
        self.rideCymbalProbability = rideCymbalProbability
    }
    
    public init(complexity: Complexity,
                uniqueMeasureCount: Int) {
        
        var shortNoteMeasures: [[Double]] = []
        var longNoteMeasures: [[Double]] = []
        for _ in 1...uniqueMeasureCount {
            
            let isShortHihatRideForm = Bool.random()
            var shortHihatRideMeasure: [Double] = []
            var longHihatRideMeasure: [Double] = []
            
            if isShortHihatRideForm {
                switch complexity {
                case .negligible, .veryLow:
                    let strideSize = Bool.random() ? 1.0 : 0.5
                    for beat in stride(from: 0, to: SectionDescriptor.MEASURE_DURATION.beats, by: strideSize) {
                        shortHihatRideMeasure.append(beat)
                    }
                case .low, .medium:
                    for halfBeat in stride(from: 0, to: SectionDescriptor.MEASURE_DURATION.beats, by: 0.5) {
                        if Bool.random(probability: 25) {
                            longHihatRideMeasure.append(halfBeat)
                        } else {
                            shortHihatRideMeasure.append(halfBeat)
                        }
                    }
                case .high, .veryHigh:
                    for halfBeat in stride(from: 0, to: SectionDescriptor.MEASURE_DURATION.beats, by: 0.5) {
                        if Bool.random(probability: 25) {
                            longHihatRideMeasure.append(halfBeat)
                        } else {
                            shortHihatRideMeasure.append(halfBeat)
                            if Bool.random(probability: 25) {
                                shortHihatRideMeasure.append(halfBeat + 0.25)
                            }
                        }
                    }
                }
                
            } else {
                switch complexity {
                case .negligible, .veryLow:
                    for beat in stride(from: 0, to: SectionDescriptor.MEASURE_DURATION.beats, by: 1.0) {
                        longHihatRideMeasure.append(beat)
                    }
                case .low, .medium:
                    for beat in stride(from: 0, to: SectionDescriptor.MEASURE_DURATION.beats, by: 1.0) {
                        longHihatRideMeasure.append(beat)
                        if Bool.random(probability: 25) {
                            longHihatRideMeasure.append(beat + 0.5)
                        }
                    }
                case .high, .veryHigh:
                    for halfBeat in stride(from: 0, to: SectionDescriptor.MEASURE_DURATION.beats, by: 0.5) {
                        if Bool.random() {
                            longHihatRideMeasure.append(halfBeat)
                        }
                    }
                }
            }
            
            shortNoteMeasures.append(shortHihatRideMeasure)
            longNoteMeasures.append(longHihatRideMeasure)
        }
        
        self.shortNoteMeasures = shortNoteMeasures
        self.longNoteMeasures = longNoteMeasures

        self.hihatPedalMode = HihatPedalMode.allCases.randomElement()!
        self.rideCymbalProbability = Int.random(in: 0...100)
    }
    
}
