//  Created by B.T. Franklin on 1/11/20.

import DunesailerUtilities

public struct BassDrumSubPartGenotype: Codable {
    
    public let preset: PercussionNoteNumber
    public let measures: [[Double]]
    
    public init(preset: PercussionNoteNumber,
                measures: [[Double]]) {
        self.preset = preset
        self.measures = measures
    }
    
    public init(complexity: Complexity,
                uniqueMeasureCount: Int,
                beatEmphasisStrategy: DrumsPartGenotype.BeatEmphasisStrategy) {
        
        self.preset = Bool.random() ? .kickDrum1 : .kickDrum2
        
        let placementCount: Int
        switch complexity {
        case .negligible:
            placementCount = 1
        case .veryLow:
            placementCount = 2
        case .low:
            placementCount = 3
        case .medium:
            placementCount = 4
        case .high:
            placementCount = 6
        case .veryHigh:
            placementCount = 8
        }
        
        var measures = [[Double]]()
        for _ in 1...uniqueMeasureCount {
            
            var remainingPlacements = placementCount
            var measure = [Double]()
            
            switch beatEmphasisStrategy {
            case .none:
                if Bool.random(probability: 95) {
                    measure.append(0.0)
                    remainingPlacements -= 1
                }
                if Bool.random(probability: 95) {
                    measure.append(2.0)
                    remainingPlacements -= 1
                }
                
                if remainingPlacements > 0 {
                    if Bool.random(probability: 95) {
                        measure.append(1.0)
                        remainingPlacements -= 1
                    }
                    if Bool.random(probability: 95) {
                        measure.append(3.0)
                        remainingPlacements -= 1
                    }
                }
                
            case .three:
                if Bool.random(probability: 95) {
                    measure.append(0.0)
                    remainingPlacements -= 1
                }
                
                let twoAndFour: [Double] = Bool.random() ? [1.0, 3.0] : [3.0, 1.0]
                if remainingPlacements > 0 && Bool.random(probability: 75) {
                    measure.append(twoAndFour.first!)
                    remainingPlacements -= 1
                }
                
                if remainingPlacements > 0 && Bool.random(probability: 75) {
                    measure.append(twoAndFour.last!)
                    remainingPlacements -= 1
                }
                
                if remainingPlacements > 0 && Bool.random(probability: 50) {
                    measure.append(2.0)
                    remainingPlacements -= 1
                }
                
                if remainingPlacements > 0 {
                    let remainingHalfBeats: [Double] = [
                        0.5, 1.5, 2.5, 3.5
                        ].shuffled()
                    
                    for beatIndex in 0..<min(remainingPlacements,remainingHalfBeats.count) {
                        measure.append(remainingHalfBeats[beatIndex])
                        remainingPlacements -= 1
                    }
                }
                
                if remainingPlacements > 0 {
                    let remainingQuarterBeats: [Double] = [
                        0.25, 0.75,
                        1.25, 1.75,
                        2.25, 2.75,
                        3.25, 3.75,
                        ].shuffled()
                    
                    for beatIndex in 0..<remainingPlacements {
                        measure.append(remainingQuarterBeats[beatIndex])
                    }
                }
                
            case .twoAndFour:
                if Bool.random(probability: 95) {
                    measure.append(0.0)
                    remainingPlacements -= 1
                }
                if Bool.random(probability: 95) {
                    measure.append(2.0)
                    remainingPlacements -= 1
                }
                
                let ordering = Bool.random() ? [0.5, 2.5] : [1.5, 3.5]
                if remainingPlacements > 0 {
                    if Bool.random(probability: 75) {
                        measure.append(ordering[0])
                        remainingPlacements -= 1
                    }
                    if Bool.random(probability: 75) {
                        measure.append(ordering[1])
                        remainingPlacements -= 1
                    }
                }
                
                if remainingPlacements > 0 {
                    if Bool.random(probability: 75) {
                        measure.append(ordering[0])
                        remainingPlacements -= 1
                    }
                    if Bool.random(probability: 75) {
                        measure.append(ordering[1])
                        remainingPlacements -= 1
                    }
                }
                
                if remainingPlacements > 0 {
                    let remainingQuarterBeats: [Double] = [
                        0.25, 0.75,
                        1.25, 1.75,
                        2.25, 2.75,
                        3.25, 3.75,
                        ].shuffled()
                    
                    for beatIndex in 0..<remainingPlacements {
                        measure.append(remainingQuarterBeats[beatIndex])
                    }
                }
            }
            
            measures.append(measure)
        }
        
        self.measures = measures
    }
    
}
