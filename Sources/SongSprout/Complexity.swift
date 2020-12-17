//  Created by B.T. Franklin on 12/18/19.

public enum Complexity: Int, Codable, CaseIterable, Comparable {
    case negligible = 0
    case veryLow
    case low
    case medium
    case high
    case veryHigh
    
    public static func < (lhs: Complexity, rhs: Complexity) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
