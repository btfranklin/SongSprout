//  Created by B.T. Franklin on 12/21/19.

struct ChordProgression {
    
    let chordDescriptors: [ChordDescriptor]
    
    init(chordFunctionCategorySequence: ChordFunctionCategorySequence,
         scale: MusicalScale,
         key: MusicalKeyName) {
        
        var chordDescriptors: [ChordDescriptor] = []
        
        for chordFunctionCategory in chordFunctionCategorySequence.chordFunctionCategories {
            
            let chordFunction: ChordFunction
            if scale.scaleType.isMajor {
                chordFunction = chordFunctionCategory.majorKeyChordFunctions.randomElement()!
            } else {
                chordFunction = chordFunctionCategory.minorKeyChordFunctions.randomElement()!
            }
            
            chordDescriptors.append(.init(scale: scale, rootScaleDegree: chordFunction.rawValue))
        }
        
        self.chordDescriptors = chordDescriptors
    }
    
}
