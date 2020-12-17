//  Created by B.T. Franklin on 12/9/19.

enum MusicalKeyName: Int, CaseIterable {
    case C = 0
    case C_sharp
    case D
    case D_sharp
    case E
    case F
    case F_sharp
    case G
    case G_sharp
    case A
    case A_sharp
    case B
}

extension MusicalKeyName: CustomStringConvertible {
    var description: String {
        switch self {
        case .C:
            return "C"
        case .C_sharp:
            return "C♯"
        case .D:
            return "D"
        case .D_sharp:
            return "D♯"
        case .E:
            return "E"
        case .F:
            return "F"
        case .F_sharp:
            return "F♯"
        case .G:
            return "G"
        case .G_sharp:
            return "G♯"
        case .A:
            return "A"
        case .A_sharp:
            return "A♯"
        case .B:
            return "B"
        }
    }
}

extension MusicalKeyName {
    var alternateName: String {
        switch self {
        case .C_sharp:
            return "D♭"
        case .D_sharp:
            return "E♭"
        case .F_sharp:
            return "G♭"
        case .G_sharp:
            return "A♭"
        case .A_sharp:
            return "B♭"
        default:
            return self.description
        }
    }
}
