//  Created by B.T. Franklin on 1/1/20.

import DunesailerUtilities
import AudioKit

public struct DrumsPartGenotype: Codable {
    
    public enum BeatEmphasisStrategy: Int, CaseIterable, Codable {
        case none
        case three
        case twoAndFour
    }
    
    public enum ReverbImplementation: Int, CaseIterable, Codable {
        case chowning
        case costello
        case appleReverb
        case zita
    }
    
    public enum FillDuration: Double, CaseIterable, Codable {
        case short = 1.0
        case medium = 2.0
        case long = 3.0
        case veryLong = 4.0
    }
    
    // Structural
    public let drumKitPreset: GeneralUserDrumKit
    public let beatEmphasisStrategy: BeatEmphasisStrategy
    public let uniqueMeasureCount: Int
    public let uniquePhraseCount: Int
    public let usesUniformMeasuresInPhrase: Bool
    
    // Stylistic
    public let fillProbability: Int
    public let fillDurations: [FillDuration]
    
    // Bass Drum
    public let bassDrumGenotype: BassDrumSubPartGenotype
    
    // Snare
    public let snareDrumGenotype: SnareDrumSubPartGenotype

    // Hihat/Ride
    public let hihatRideGenotype: HihatRideSubPartGenotype
    
    // Cymbals
    public let cymbalGenotype: CymbalSubPartGenotype

    // Effects
    public let reverbImplementation: ReverbImplementation
    public let reverbMix: AUValue
    
    public init(drumKitPreset: GeneralUserDrumKit,
                beatEmphasisStrategy: BeatEmphasisStrategy,
                uniqueMeasureCount: Int,
                uniquePhraseCount: Int,
                usesUniformMeasuresInPhrase: Bool,
                fillProbability: Int,
                fillDurations: [FillDuration],
                bassDrumGenotype: BassDrumSubPartGenotype,
                snareDrumGenotype: SnareDrumSubPartGenotype,
                hihatRideGenotype: HihatRideSubPartGenotype,
                cymbalGenotype: CymbalSubPartGenotype,
                reverbImplementation: ReverbImplementation,
                reverbMix: AUValue) {
        self.drumKitPreset = drumKitPreset
        self.beatEmphasisStrategy = beatEmphasisStrategy
        self.uniqueMeasureCount = uniqueMeasureCount
        self.uniquePhraseCount = uniquePhraseCount
        self.usesUniformMeasuresInPhrase = usesUniformMeasuresInPhrase
        self.fillProbability = fillProbability
        self.fillDurations = fillDurations
        self.bassDrumGenotype = bassDrumGenotype
        self.snareDrumGenotype = snareDrumGenotype
        self.hihatRideGenotype = hihatRideGenotype
        self.cymbalGenotype = cymbalGenotype
        self.reverbImplementation = reverbImplementation
        self.reverbMix = reverbMix
    }
    
    public init(complexity: Complexity) {
        
        self.drumKitPreset = GeneralUserDrumKit.allCases.randomElement()!
        
        switch Int.random(in: 1...100) {
        case 1...40:
            self.beatEmphasisStrategy = .three
        case 41...80:
            self.beatEmphasisStrategy = .twoAndFour
        default:
            self.beatEmphasisStrategy = .none
        }
        
        let fillDurationOptionCount: Int
        switch complexity {
        case .negligible:
            self.uniqueMeasureCount = 1
            self.uniquePhraseCount = 1
            self.usesUniformMeasuresInPhrase = true
            fillDurationOptionCount = 1
        case .veryLow:
            self.uniqueMeasureCount = 1
            self.uniquePhraseCount = 1
            self.usesUniformMeasuresInPhrase = true
            fillDurationOptionCount = 1
        case .low:
            self.uniqueMeasureCount = 1
            self.uniquePhraseCount = 2
            self.usesUniformMeasuresInPhrase = true
            fillDurationOptionCount = 2
        case .medium:
            self.uniqueMeasureCount = 2
            self.uniquePhraseCount = 3
            self.usesUniformMeasuresInPhrase = false
            fillDurationOptionCount = 2
        case .high:
            self.uniqueMeasureCount = 2
            self.uniquePhraseCount = 4
            self.usesUniformMeasuresInPhrase = false
            fillDurationOptionCount = 3
        case .veryHigh:
            self.uniqueMeasureCount = 4
            self.uniquePhraseCount = 4
            self.usesUniformMeasuresInPhrase = false
            fillDurationOptionCount = 3
        }
        
        self.fillProbability = Int.random(in: 0...100)
        var fillDurations = Set<FillDuration>()
        while fillDurations.count < fillDurationOptionCount {
            fillDurations.insert(FillDuration.allCases.randomElement()!)
        }
        self.fillDurations = fillDurations.compactMap { $0 }.sorted(by: {$0.rawValue < $1.rawValue})

        self.bassDrumGenotype = BassDrumSubPartGenotype(complexity: complexity,
                                                        uniqueMeasureCount: self.uniqueMeasureCount,
                                                        beatEmphasisStrategy: self.beatEmphasisStrategy)
        
        self.snareDrumGenotype = SnareDrumSubPartGenotype(complexity: complexity,
                                                          uniqueMeasureCount: self.uniqueMeasureCount,
                                                          beatEmphasisStrategy: self.beatEmphasisStrategy,
                                                          bassDrumGenotype: self.bassDrumGenotype,
                                                          isBrushKit: self.drumKitPreset == .brush)

        self.hihatRideGenotype = HihatRideSubPartGenotype(complexity: complexity,
                                                          uniqueMeasureCount: self.uniqueMeasureCount)
        
        self.cymbalGenotype = CymbalSubPartGenotype(complexity: complexity,
                                                    uniqueMeasureCount: self.uniqueMeasureCount,
                                                    bassDrumGenotype: self.bassDrumGenotype,
                                                    snareDrumGenotype: self.snareDrumGenotype)

        self.reverbImplementation = ReverbImplementation.allCases.randomElement()!
        self.reverbMix = AUValue.random(in: 0.0...1.0)
    }
    
}
