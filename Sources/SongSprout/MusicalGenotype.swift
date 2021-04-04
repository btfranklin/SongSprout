//  Created by B.T. Franklin on 12/8/19.

import AudioKit
import DunesailerUtilities

public struct MusicalGenotype: Codable {

    static private let chordFunctionCategorySequenceLengthBag = RandomItemBag<Int>([
        2:  25,
        3:  25,
        4: 150,
        5:  75,
        6:  75,
    ])
    
    public let scaleType: MusicalScaleType
    public let complexity: Complexity
    public let flowPattern: MusicalFlowPattern
    public let chordFunctionCategorySequences: [ChordFunctionCategorySequence]
    public let motifCount: Int
    
    public let partIdentifiers: [PartIdentifier]
    public let drumsPartGenotype: DrumsPartGenotype?
    public let accompanimentPartGenotype: AccompanimentPartGenotype?
    public let leadPartGenotype: LeadPartGenotype?
    public let bassPartGenotype: BassPartGenotype?
    public let padPartGenotype: PadPartGenotype?
    public let arpeggiatorPartGenotype: ArpeggiatorPartGenotype?
    public let dronePartGenotype: DronePartGenotype?

    public init(scaleType: MusicalScaleType,
                complexity: Complexity,
                flowPattern: MusicalFlowPattern,
                chordFunctionCategorySequences: [ChordFunctionCategorySequence],
                motifCount: Int,
                partIdentifiers: [PartIdentifier],
                drumsPartGenotype: DrumsPartGenotype?,
                accompanimentPartGenotype: AccompanimentPartGenotype?,
                leadPartGenotype: LeadPartGenotype?,
                bassPartGenotype: BassPartGenotype?,
                padPartGenotype: PadPartGenotype?,
                arpeggiatorPartGenotype: ArpeggiatorPartGenotype?,
                dronePartGenotype: DronePartGenotype?) {
        
        self.scaleType = scaleType
        self.complexity = complexity
        self.flowPattern = flowPattern
        self.chordFunctionCategorySequences = chordFunctionCategorySequences
        self.motifCount = motifCount
        self.partIdentifiers = partIdentifiers
        self.drumsPartGenotype = drumsPartGenotype
        self.accompanimentPartGenotype = accompanimentPartGenotype
        self.leadPartGenotype = leadPartGenotype
        self.bassPartGenotype = bassPartGenotype
        self.padPartGenotype = padPartGenotype
        self.arpeggiatorPartGenotype = arpeggiatorPartGenotype
        self.dronePartGenotype = dronePartGenotype
    }
    
    public init() {
        self.scaleType = MusicalScaleType.weightedRandomElement()
        
        self.complexity = Complexity.allCases.randomElement()!
        
        self.flowPattern = MusicalFlowPattern()
        
        var chordFunctionCategorySequences: [ChordFunctionCategorySequence] = []
        for _ in 1...2 {
            let sequenceLength = MusicalGenotype.chordFunctionCategorySequenceLengthBag.randomItem()!
            chordFunctionCategorySequences.append(ChordFunctionCategorySequence(length: sequenceLength))
        }
        self.chordFunctionCategorySequences = chordFunctionCategorySequences
        
        switch self.complexity {
        case .negligible, .veryLow:
            self.motifCount = 1
        case .low, .medium:
            self.motifCount = 2
        case .high, .veryHigh:
            self.motifCount = 3
        }

        var partIdentifiers = Set<PartIdentifier>()

        partIdentifiers.insert(.lead)
        while partIdentifiers.count < 4 {
            
            // Tier 1
            if Bool.random(probability: 90) {
                partIdentifiers.insert(.drums)
            }
            if Bool.random(probability: 75) {
                partIdentifiers.insert(.accompaniment)
            }
            if Bool.random(probability: 75) {
                partIdentifiers.insert(.bass)
            }
            if Bool.random(probability: 50) {
                partIdentifiers.insert(.pad)
            }
            
            // Tier 2
            if Bool.random(probability: 25) {
                partIdentifiers.insert(.drone)
            }
            if Bool.random(probability: 25) {
                partIdentifiers.insert(.arpeggiator)
            }
        }

        var drumsPartGenotype: DrumsPartGenotype? = nil
        var accompanimentPartGenotype: AccompanimentPartGenotype? = nil
        var leadPartGenotype: LeadPartGenotype? = nil
        var bassPartGenotype: BassPartGenotype? = nil
        var padPartGenotype: PadPartGenotype? = nil
        var arpeggiatorPartGenotype: ArpeggiatorPartGenotype? = nil
        var dronePartGenotype: DronePartGenotype? = nil
        for partIdentifier in partIdentifiers {
            switch partIdentifier {
            case .drums:
                drumsPartGenotype = DrumsPartGenotype(complexity: complexity)

            case .accompaniment:
                accompanimentPartGenotype = AccompanimentPartGenotype(complexity: complexity)

            case .lead:
                leadPartGenotype = LeadPartGenotype(complexity: complexity)

            case .bass:
                bassPartGenotype = BassPartGenotype(complexity: complexity)

            case .pad:
                padPartGenotype = PadPartGenotype(complexity: complexity)

            case .arpeggiator:
                arpeggiatorPartGenotype = ArpeggiatorPartGenotype(complexity: complexity)
                
            case .drone:
                dronePartGenotype = DronePartGenotype()
            }
        }
        
        self.partIdentifiers = partIdentifiers.map {$0}
        self.drumsPartGenotype = drumsPartGenotype
        self.accompanimentPartGenotype = accompanimentPartGenotype
        self.leadPartGenotype = leadPartGenotype
        self.bassPartGenotype = bassPartGenotype
        self.padPartGenotype = padPartGenotype
        self.arpeggiatorPartGenotype = arpeggiatorPartGenotype
        self.dronePartGenotype = dronePartGenotype
    }
    
}
