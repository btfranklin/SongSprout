//  Created by B.T. Franklin on 12/22/19.

public struct ChordFunctionCategorySequence: Hashable, Codable {
    
    public let chordFunctionCategories: [ChordFunctionCategory]
    
    public init(chordFunctionCategories: [ChordFunctionCategory]) {
        self.chordFunctionCategories = chordFunctionCategories
    }
    
    public init(length: Int) {
        
        guard (1...6).contains(length) else {
            fatalError("ChordFunctionCategorySequence length must be in the range 1 through 6")
        }
        
        var chordFunctionCategories = [ChordFunctionCategory]()
        
        for position in 1...length {
            if position == 1 {
                chordFunctionCategories.append(.tonic)
                
            } else {
                let previousCategory = chordFunctionCategories.last!
                let isFinalPosition = (position == length)
                switch previousCategory {
                case .tonic:
                    if isFinalPosition {
                        chordFunctionCategories.append(Bool.random() ? .dominant : .subdominant)
                    } else {
                        chordFunctionCategories.append(Bool.random() ? .substituteTonic : .subdominant)
                    }
                case .substituteTonic:
                    if isFinalPosition {
                        if length > 3 {
                            chordFunctionCategories.append(.dominant)
                        } else {
                            chordFunctionCategories.append(Bool.random() ? .dominant : .subdominant)
                        }
                    } else {
                        chordFunctionCategories.append(.subdominant)
                    }
                case .subdominant:
                    if isFinalPosition {
                        chordFunctionCategories.append(.dominant)
                    } else {
                        chordFunctionCategories.append(Bool.random() ? .substituteTonic : .subdominant)
                    }
                case .dominant:
                    fatalError("Something has gone wrong. A dominant chord must always be the last chord in a sequence.")
                }
            }
        }
        
        self.chordFunctionCategories = chordFunctionCategories
    }
    
}

extension ChordFunctionCategorySequence: CustomStringConvertible {
    public var description: String {
        String(describing: chordFunctionCategories)
    }
}
