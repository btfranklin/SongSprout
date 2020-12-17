//  Created by B.T. Franklin on 12/21/19.

public enum ChordFunctionCategory: Int, Hashable, Codable, CaseIterable {
    case tonic = 0
    case substituteTonic
    case subdominant
    case dominant
}

extension ChordFunctionCategory {
    
    public var majorKeyChordFunctions: [ChordFunction] {
        switch self {
        case .tonic:
            return [.tonic]
        case .substituteTonic:
            return [.mediant, .submediant]
        case .subdominant:
            return [.subdominant, .supertonic]
        case .dominant:
            return [.dominant, .leadingTone]
        }
    }
    
    public var minorKeyChordFunctions: [ChordFunction] {
        switch self {
        case .tonic:
            return [.tonic]
        case .substituteTonic:
            return [.mediant]
        case .subdominant:
            return [.subdominant, .submediant]
        case .dominant:
            return [.dominant, .leadingTone, .supertonic]
        }
    }
/* TODO currently just using minor for all non-majors
    func chordFunctionsForScaleType(_ scaleType: MusicalScaleType) -> [ChordFunction] {
        switch scaleType {
        case .major:
            return majorKeyChordFunctions
            
        case .majorPentatonic:
            
            
        case .naturalMinor:
            return minorKeyChordFunctions
            
        case .minorPentatonic:
            
            
        case .dorian:
            
            
        case .mixolydian:
            
            
        case .diatonic:
            
            
        case .harmonicMinor:
            
            
        case .doubleHarmonicMajor:
            
            
        case .doubleHarmonicMinor:
            
            
        case .phrygianDominant:
            
        }
    }
 */
}

extension ChordFunctionCategory {
    public var characteristicScaleDegrees: [Int] {
        switch self {
        case .tonic, .substituteTonic:
            return [0, 2, 4, 5, 6]
        case .subdominant:
            return [0, 1, 2, 3, 5]
        case .dominant:
            return [1, 3, 4, 5, 6]
        }
    }
    
    public var characteristicScaleDegreeTriggers: [Int] {
        switch self {
        case .tonic, .substituteTonic:
            return [0, 2]
        case .subdominant:
            return [3, 5]
        case .dominant:
            return [4, 6]
        }
    }
}

/* TODO Chord Functions: Analytical version
 To determine the function of a chord, find the function that includes all the scale degrees of a chord . If more than one function contains all the scale degrees, take the function with the most triggers in the chord.
 
 There is one exception to this (for now): a chord with scale degrees 6, 1, and 3 is a special kind of tonic chord, called a destabilized tonic. Quinn uses the special functional label is Tx, rather than simply T, for this chord.
 
 Also note that because the III7 chord’s scale-degrees do not wholly belong to any of the three functions, it can behave similar to T and D chords, depending on context. It is a rare chord in its diatonic form.
 */

extension ChordFunctionCategory: CustomStringConvertible {
    public var description: String {
        switch self {
        case .tonic:
            return "T"
        case .substituteTonic:
            return "(T)"
        case .subdominant:
            return "S"
        case .dominant:
            return "D"
        }
    }
}
