//  Created by B.T. Franklin on 12/9/19.

import DunesailerUtilities

public enum MusicalScaleType: String, Codable {
    
    case major                  // Ionian
    case dorian                 // Dorian
    case phrygian               // Phrygian
    case lydian                 // Lydian
    case mixolydian             // Mixolydian
    case naturalMinor           // Aeolian
    case locrian                // Locrian
    
    // Non-diatonics
    case harmonicMinor
    case phrygianDominant
    case doubleHarmonicMajor
    case doubleHarmonicMinor

    // Pentatonics
    case majorPentatonic
    case minorPentatonic
}

extension MusicalScaleType {
    var isMajor: Bool {
        self == .major || self == .majorPentatonic || self == .doubleHarmonicMajor
    }
    
    var isMinor: Bool {
        !isMajor
    }
}

extension MusicalScaleType {
    public var intervals: [Int] {
        switch self {
        case .major:                // Ionian
            return [2,2,1,2,2,2]
        case .dorian:               // Dorian
            return [2,1,2,2,2,1]
        case .phrygian:             // Phrygian
            return [1,2,2,2,1,2]
        case .lydian:               // Lydian
            return [2,2,2,1,2,1]
        case .mixolydian:           // Mixolydian
            return [2,2,1,2,2,1]
        case .naturalMinor:         // Aeolian
            return [2,1,2,2,1,2]
        case .locrian:              // Locrian
            return [1,2,2,1,2,2]

        // Non-diatonics
        case .harmonicMinor:
            return [2,1,2,2,1,3]
        case .phrygianDominant:
            return [1,3,1,2,1,2]
        case .doubleHarmonicMajor:
            return [1,3,1,2,1,3]
        case .doubleHarmonicMinor:
            return [2,1,3,1,1,3]
            
        // Pentatonics
        case .minorPentatonic:
            return [3,2,2,3]
        case .majorPentatonic:
            return [2,2,3,2]
        }
    }
}

extension MusicalScaleType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .major:                // Ionian
            return "Maj"
        case .dorian:               // Dorian
            return "Dor"
        case .phrygian:             // Phrygian
            return "Phrg"
        case .lydian:               // Lydian
            return "Lyd"
        case .mixolydian:           // Mixolydian
            return "Mix"
        case .naturalMinor:         // Aeolian
            return "Min"
        case .locrian:              // Locrian
            return "Loc"
            
        // Non-diatonics
        case .harmonicMinor:
            return "HrMn"
        case .phrygianDominant:
            return "PhrD"
        case .doubleHarmonicMajor:
            return "2HMj"
        case .doubleHarmonicMinor:
            return "2HMn"
            
        // Pentatonics
        case .majorPentatonic:
            return "Maj5"
        case .minorPentatonic:
            return "Min5"
        }
    }
}

extension MusicalScaleType {
    public static func weightedRandomElement() -> MusicalScaleType {
        
        let bag = RandomItemBag<MusicalScaleType>([
            .major:                 100,
            .mixolydian:             35,
            .naturalMinor:          100,
            .harmonicMinor:          35,
        ])
        
        return bag.randomItem()!
    }
}
