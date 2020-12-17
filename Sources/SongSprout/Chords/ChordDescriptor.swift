//  Created by B.T. Franklin on 12/22/19.

struct ChordDescriptor {
    
    static let TRIAD_COMPONENTS = [0,2,4]
    static let SEVENTH_COMPONENTS = [0,2,4,6]
    static let SUS4_COMPONENTS = [0,3,4]
    
    let keyNames: [MusicalKeyName]
    
    init(scale: MusicalScale, rootScaleDegree: Int, components: [Int] = TRIAD_COMPONENTS) {
        
        guard (0..<scale.keyNames.count).contains(rootScaleDegree) else {
            fatalError("Attempted to construct Chord with scale degree \(rootScaleDegree) in \(scale)")
        }
        
        var keyNames = [MusicalKeyName]()
        for component in components {
            let scaleDegree = (rootScaleDegree + component) % scale.keyNames.count
            keyNames.append(scale.keyNames[scaleDegree])
        }
        self.keyNames = keyNames
    }
}

extension ChordDescriptor: CustomStringConvertible {
    var description: String {
        var keyNames = [String]()
        for keyName in self.keyNames {
            keyNames.append(keyName.description)
        }
        return keyNames.joined(separator: "-")
    }
}
