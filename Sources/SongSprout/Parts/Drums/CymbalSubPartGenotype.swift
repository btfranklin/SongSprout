//  Created by B.T. Franklin on 6/14/20.

import ControlledChaos

public struct CymbalSubPartGenotype: Codable {
    
    public let hitOnPhraseStartProbability: Int
    public let hitOnPlacementProbability: Int
    public let primaryMeasures: [[Double]]
    public let secondaryMeasures: [[Double]]
    
    public init(hitOnPhraseStartProbability: Int,
                hitOnPlacementProbability: Int,
                primaryMeasures: [[Double]],
                secondaryMeasures: [[Double]]) {
        self.hitOnPhraseStartProbability = hitOnPhraseStartProbability
        self.hitOnPlacementProbability = hitOnPlacementProbability
        self.primaryMeasures = primaryMeasures
        self.secondaryMeasures = secondaryMeasures
    }

    // TODO change this to bring in beat emphasis again, and maybe do like snare does and just break on .none
    public init(complexity: Complexity,
                uniqueMeasureCount: Int,
                bassDrumGenotype: BassDrumSubPartGenotype,
                snareDrumGenotype: SnareDrumSubPartGenotype) {
        
        hitOnPhraseStartProbability = Int.random(in: 75...100)
        hitOnPlacementProbability = Int.random(in: 0...100)

        var primaryMeasures: [[Double]] = []
        var secondaryMeasures: [[Double]] = []
        for measureIndex in 0..<uniqueMeasureCount {
            
            var primaryMeasure: [Double] = []
            var secondaryMeasure: [Double] = []
            
            var bassDrumMeasure = bassDrumGenotype.measures[measureIndex]
            var snareDrumMeasure = snareDrumGenotype.measures[measureIndex]
            
            let placementCount: Int
            switch complexity {
            case .negligible:
                placementCount = 0
            case .veryLow, .low:
                placementCount = 1
            case .medium:
                placementCount = Bool.random() ? 2 : 1
            case .high, .veryHigh:
                placementCount = Bool.random() ? 3 : 2
            }
            
            var remainingPlacements = placementCount
            
            // Hit on beat 1
            if remainingPlacements > 0 && Bool.random(probability: 80) && (bassDrumMeasure.contains(0.0) || snareDrumMeasure.contains(0.0)) {
                primaryMeasure.append(0.0)
                
                bassDrumMeasure.removeAll(where: {$0 == 0.0})
                snareDrumMeasure.removeAll(where: {$0 == 0.0})

                remainingPlacements -= 1
            }

            // Hit on beat 3
            if remainingPlacements > 0 && Bool.random(probability: 80) && (bassDrumMeasure.contains(2.0) || snareDrumMeasure.contains(2.0)) {
                if Bool.random() {
                    primaryMeasure.append(2.0)
                } else {
                    secondaryMeasure.append(2.0)
                }

                bassDrumMeasure.removeAll(where: {$0 == 2.0})
                snareDrumMeasure.removeAll(where: {$0 == 2.0})
                
                remainingPlacements -= 1
            }

            // Hit on beat 2
            if remainingPlacements > 0 && Bool.random(probability: 60) && (bassDrumMeasure.contains(1.0) || snareDrumMeasure.contains(1.0)) {
                if Bool.random() {
                    primaryMeasure.append(1.0)
                } else {
                    secondaryMeasure.append(1.0)
                }
                
                bassDrumMeasure.removeAll(where: {$0 == 1.0})
                snareDrumMeasure.removeAll(where: {$0 == 1.0})
                
                remainingPlacements -= 1
            }
            
            // Hit on beat 4
            if remainingPlacements > 0 && Bool.random(probability: 60) && (bassDrumMeasure.contains(3.0) || snareDrumMeasure.contains(3.0)) {
                if Bool.random() {
                    primaryMeasure.append(3.0)
                } else {
                    secondaryMeasure.append(3.0)
                }
                
                bassDrumMeasure.removeAll(where: {$0 == 3.0})
                snareDrumMeasure.removeAll(where: {$0 == 3.0})
                
                remainingPlacements -= 1
            }
            
            // Hit anywhere that's left
            while remainingPlacements > 0 && bassDrumMeasure.isNotEmpty && snareDrumMeasure.isNotEmpty {
                
                if Bool.random(probability: 80) && bassDrumMeasure.isNotEmpty {
                    let placementLocation = bassDrumMeasure.remove(at: Int.random(in: 0..<bassDrumMeasure.count))
                    
                    if Bool.random() {
                        primaryMeasure.append(placementLocation)
                    } else {
                        secondaryMeasure.append(placementLocation)
                    }
                    remainingPlacements -= 1

                } else if snareDrumMeasure.isNotEmpty {
                    let placementLocation = snareDrumMeasure.remove(at: Int.random(in: 0..<snareDrumMeasure.count))

                    if Bool.random() {
                        primaryMeasure.append(placementLocation)
                    } else {
                        secondaryMeasure.append(placementLocation)
                    }
                    remainingPlacements -= 1
                }
            }
            
            primaryMeasures.append(primaryMeasure.sorted())
            secondaryMeasures.append(secondaryMeasure.sorted())
        }
        
        self.primaryMeasures = primaryMeasures
        self.secondaryMeasures = secondaryMeasures
    }
    
}
