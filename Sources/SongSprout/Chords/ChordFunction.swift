//  Created by B.T. Franklin on 12/21/19.

public enum ChordFunction: Int, Hashable, Codable, CaseIterable {
    case tonic = 0
    case supertonic
    case mediant
    case subdominant
    case dominant
    case submediant
    case leadingTone
}

extension ChordFunction: CustomStringConvertible {
    public var description: String {
        switch self {
        case .tonic:
            return "tonic"
        case .supertonic:
            return "supertonic"
        case .mediant:
            return "mediant"
        case .subdominant:
            return "subdominant"
        case .dominant:
            return "dominant"
        case .submediant:
            return "submediant"
        case .leadingTone:
            return "leading tone"
        }
    }
}
