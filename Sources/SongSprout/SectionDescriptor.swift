//  Created by B.T. Franklin on 12/18/19.

import AudioKit

public struct SectionDescriptor: Codable {
    
    public enum Designation: String, Codable, CaseIterable {
        case i // intro
        case A
        case B
        case C
        case D
        case b // break
        case f // finale
    }
    
    public enum Density: Int, Codable, Comparable {
        case minimal = 1
        case enhanced
        case complete
        
        public static func < (lhs: Density, rhs: Density) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
    
    public static let MEASURE_DURATION = Duration(beats: 4)
    
    public static let NORMAL_DESIGNATIONS: [Designation] = [
        .A, .B, .C, .D
    ]
    
    public var phraseDuration: Duration {
        Duration(beats: SectionDescriptor.MEASURE_DURATION.beats * Double(measuresInPhrase))
    }

    public let designation: Designation
    public let density: Density
    public let measuresInPhrase: Int
    public let phraseCount: Int
}
