//  Created by B.T. Franklin on 1/12/20.

import DunesailerUtilities

public struct SnareDrumSubPartGenotype: Codable {
    
    public let preset: PercussionNoteNumber
    public let ghostPreset: PercussionNoteNumber
    public let measures: [[Double]]
    public let ghostMeasures: [[Double]]
    
    public init(preset: PercussionNoteNumber,
                ghostPreset: PercussionNoteNumber,
                measures: [[Double]],
                ghostMeasures: [[Double]]) {
        self.preset = preset
        self.ghostPreset = ghostPreset
        self.measures = measures
        self.ghostMeasures = ghostMeasures
    }

    public init(complexity: Complexity,
                uniqueMeasureCount: Int,
                beatEmphasisStrategy: DrumsPartGenotype.BeatEmphasisStrategy,
                bassDrumGenotype: BassDrumSubPartGenotype,
                isBrushKit: Bool) {
        
        if isBrushKit {
            self.preset = .handClap // This is a brush slap on the brush kit
            self.ghostPreset = Bool.random() ? .snareDrum1 : .snareDrum2 // These are a brush tap and swirl on the brush kit
        } else {
            self.preset = Bool.random() ? .snareDrum1 : .snareDrum2
            self.ghostPreset = self.preset
        }

        let placementCount: Int
        var hasGhostHits: Bool
        switch complexity {
        case .negligible:
            placementCount = 1
            hasGhostHits = false
        case .veryLow:
            placementCount = 1
            hasGhostHits = Bool.random(probability: 25)
        case .low:
            placementCount = 1
            hasGhostHits = Bool.random(probability: 33)
        case .medium:
            placementCount = Bool.random(probability: 10) ? 2 : 1
            hasGhostHits = Bool.random(probability: 33)
        case .high:
            placementCount = Bool.random(probability: 25) ? 2 : 1
            hasGhostHits = Bool.random(probability: 50)
        case .veryHigh:
            placementCount = Bool.random(probability: 25) ? 2 : 1
            hasGhostHits = Bool.random(probability: 50)
        }

        if isBrushKit {
            hasGhostHits = true
        }
        
        var measures = [[Double]]()
        var ghostMeasures = [[Double]]()
        for measureIndex in 0..<uniqueMeasureCount {
            
            var measure = [Double]()
            var ghostMeasure = [Double]()
            
            switch beatEmphasisStrategy {
            case .none:
                break
                
            case .three:
                var remainingPlacements = hasGhostHits ? placementCount * 4 : placementCount

                // Hit on beat 3
                if remainingPlacements > 0 && Bool.random(probability: 95) {
                    measure.append(2.0)
                    remainingPlacements -= 1
                }
                
                let twoAndFour: [Double] = bassDrumGenotype.measures[measureIndex].contains(1.0) ? [1.0, 3.0] : [3.0, 1.0]
                
                // Hit on beat 2 or 4
                if remainingPlacements > 0 && Bool.random(probability: 75) {
                    if hasGhostHits && Bool.random(probability: 75) {
                        ghostMeasure.append(twoAndFour.last!)
                    } else {
                        measure.append(twoAndFour.last!)
                    }
                    remainingPlacements -= 1
                }
                
                // Hit on beat 2 or 4 (whichever one is left)
                if remainingPlacements > 0 && Bool.random(probability: 75) {
                    if hasGhostHits && Bool.random(probability: 75) {
                        ghostMeasure.append(twoAndFour.first!)
                    } else {
                        measure.append(twoAndFour.first!)
                    }
                    remainingPlacements -= 1
                }
                
                // Hit on beat 1
                if remainingPlacements > 0 && Bool.random(probability: 50) {
                    if hasGhostHits && Bool.random(probability: 75) {
                        ghostMeasure.append(0.0)
                    } else {
                        measure.append(0.0)
                    }
                    remainingPlacements -= 1
                }
                
                // Hit on any half-beat
                if remainingPlacements > 0 {
                    let remainingHalfBeats: [Double] = [
                        0.5, 1.5, 2.5, 3.5
                    ].shuffled()
                    
                    for beatIndex in 0..<min(remainingPlacements,remainingHalfBeats.count) {
                        if hasGhostHits {
                            ghostMeasure.append(remainingHalfBeats[beatIndex])
                        } else {
                            measure.append(remainingHalfBeats[beatIndex])
                        }
                        remainingPlacements -= 1
                    }
                }
                
                // Hit on any quarter-beat
                if remainingPlacements > 0 {
                    let remainingQuarterBeats: [Double] = [
                        0.25, 0.75,
                        1.25, 1.75,
                        2.25, 2.75,
                        3.25, 3.75,
                    ].shuffled()
                    
                    for beatIndex in 0..<remainingPlacements {
                        if hasGhostHits {
                            ghostMeasure.append(remainingQuarterBeats[beatIndex])
                        } else {
                            measure.append(remainingQuarterBeats[beatIndex])
                        }
                    }
                }
                
            case .twoAndFour:
                var remainingPlacements = hasGhostHits ? placementCount * 4 : placementCount

                // Hit on beats 2 and 4
                if Bool.random(probability: 95) {
                    measure.append(1.0)
                    remainingPlacements -= 1
                }
                if Bool.random(probability: 95) {
                    measure.append(3.0)
                    remainingPlacements -= 1
                }
                
                // Hit on beats 1 and 3
                let ordering = Bool.random() ? [0.0, 2.0] : [2.0, 0.0]
                if remainingPlacements > 0 {
                    if Bool.random(probability: 75) {
                        if hasGhostHits {
                            ghostMeasure.append(ordering[0])
                        } else {
                            measure.append(ordering[0])
                        }
                        remainingPlacements -= 1
                    }
                    if Bool.random(probability: 75) {
                        if hasGhostHits {
                            ghostMeasure.append(ordering[1])
                        } else {
                            measure.append(ordering[1])
                        }
                        remainingPlacements -= 1
                    }
                }
                
                // Hit on any half-beat
                if remainingPlacements > 0 {
                    let remainingHalfBeats: [Double] = [
                        0.5, 1.5, 2.5, 3.5
                    ].shuffled()
                    
                    for beatIndex in 0..<min(remainingPlacements,remainingHalfBeats.count) {
                        if hasGhostHits {
                            ghostMeasure.append(remainingHalfBeats[beatIndex])
                        } else {
                            measure.append(remainingHalfBeats[beatIndex])
                        }
                        remainingPlacements -= 1
                    }
                }
                
                // Hit on any quarter-beat
                if remainingPlacements > 0 {
                    let remainingQuarterBeats: [Double] = [
                        0.25, 0.75,
                        1.25, 1.75,
                        2.25, 2.75,
                        3.25, 3.75,
                    ].shuffled()
                    
                    for beatIndex in 0..<remainingPlacements {
                        if hasGhostHits {
                            ghostMeasure.append(remainingQuarterBeats[beatIndex])
                        } else {
                            measure.append(remainingQuarterBeats[beatIndex])
                        }
                    }
                }
            }

            measures.append(measure)
            ghostMeasures.append(ghostMeasure)
        }

        self.measures = measures
        self.ghostMeasures = ghostMeasures
    }
    
}
