//  Created by B.T. Franklin on 12/22/19.

struct MusicalScale {
    
    let scaleType: MusicalScaleType
    let keyNames: [MusicalKeyName]
    
    init(scaleType: MusicalScaleType, key: MusicalKeyName) {
        
        self.scaleType = scaleType
        
        let allKeyNames = MusicalKeyName.allCases
        var keyNames = [MusicalKeyName]()
        keyNames.append(key)

        var chromaticOffset = key.rawValue
        for interval in scaleType.intervals {
            chromaticOffset += interval
            chromaticOffset %= 12
            keyNames.append(allKeyNames[chromaticOffset])
        }
        
        self.keyNames = keyNames
    }
    
    func pitches(fromOctave lowOctave: Int, toOctave highOctave: Int) -> [Pitch] {
        var pitches = [Pitch]()
        
        var currentOctave = lowOctave
        var previousPitch: Pitch?
        while currentOctave <= highOctave {
            for keyName in keyNames {
                var pitch = Pitch(key: keyName, octave: currentOctave)
                if previousPitch?.midiNoteNumber ?? 0 > pitch.midiNoteNumber {
                    currentOctave += 1
                    pitch = Pitch(key: keyName, octave: currentOctave)
                }
                pitches.append(pitch)
                previousPitch = pitch
            }
        }
        
        return pitches
    }
}

extension MusicalScale: CustomStringConvertible {
    var description: String {
        "\(keyNames[0]) \(scaleType): \(keyNames)"
    }
}
