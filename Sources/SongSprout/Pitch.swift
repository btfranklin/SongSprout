//  Created by B.T. Franklin on 12/20/19.

import AudioKit

struct Pitch: Hashable, Comparable {
    
    let key: MusicalKeyName
    let octave: Int
    let midiNoteNumber: MIDINoteNumber
    
    init(key: MusicalKeyName, octave: Int) {
        guard (0...10).contains(octave) else {
            fatalError("Pitch must be in an octave in the range 0 - 10")
        }
        
        self.key = key
        self.octave = octave
        midiNoteNumber = MIDINoteNumber(key.rawValue + (12 * octave))
    }
    
    func octaveShifted(by delta: Int) -> Pitch {
        .init(key: self.key, octave: self.octave + delta)
    }
    
    static func < (lhs: Pitch, rhs: Pitch) -> Bool {
        lhs.midiNoteNumber < rhs.midiNoteNumber
    }
    
}

extension Pitch: CustomStringConvertible {
    var description: String {
        "\(key)\(octave)"
    }
}
