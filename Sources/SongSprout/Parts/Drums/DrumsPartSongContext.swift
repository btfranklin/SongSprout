//  Created by B.T. Franklin on 1/3/20.

class DrumsPartSongContext {
    
    let normalPhrases: [[Int]] // expressed as sequences of indices into genotype's measures
    let isDanceKit: Bool
    
    init(_ partGenotype: DrumsPartGenotype) {
        
        self.isDanceKit = partGenotype.drumKitPreset == .dance || partGenotype.drumKitPreset == .electronic
        
        var normalPhrases = [[Int]]()
        for _ in 1...partGenotype.uniquePhraseCount {
            var phrase: [Int]
            
            if partGenotype.usesUniformMeasuresInPhrase {
                let measureIndex = Int.random(in: 0..<partGenotype.uniqueMeasureCount)
                phrase = .init(repeating: measureIndex, count: 4)
            } else {
                // TODO Maybe a different configuration here
                let measureIndex1 = Int.random(in: 0..<partGenotype.uniqueMeasureCount)
                let measureIndex2 = Int.random(in: 0..<partGenotype.uniqueMeasureCount)
                phrase = [measureIndex1, measureIndex2, measureIndex1, measureIndex2]
            }
            
            normalPhrases.append(phrase)
        }
        self.normalPhrases = normalPhrases
    }
}
