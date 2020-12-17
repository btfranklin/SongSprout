//  Created by B.T. Franklin on 12/22/19.

struct Chord {
    
    let descriptor: ChordDescriptor
    let pitches: [Pitch]
    let root: Pitch
    let inversion: Int
    let octave: Int
    
    var pitchCenterFrequency: Double {
        var pitchTotal = 0.0
        for pitch in pitches {
            pitchTotal += Double(pitch.midiNoteNumber.midiNoteToFrequency())
        }
        return (pitchTotal / Double(pitches.count))
    }
    
    init(from descriptor: ChordDescriptor, octave: Int, inversion: Int = 0) {
        
        self.descriptor = descriptor
        
        guard (1...9).contains(octave) else {
            fatalError("Octave must be in the range 1 - 9. Octave requested was \(octave)")
        }
        self.octave = octave
        
        guard (-(descriptor.keyNames.count-1)...descriptor.keyNames.count-1).contains(inversion) else {
            fatalError("Requested inversion \(inversion). Chord has \(descriptor.keyNames.count-1) possible.")
        }
        
        self.root = .init(key: descriptor.keyNames.first!, octave: octave)
        self.inversion = inversion
        
        var pitches = [Pitch]()
        for key in descriptor.keyNames {
            let pitch = Pitch(key: key, octave: octave)
            if pitches.last?.midiNoteNumber ?? 0 > pitch.midiNoteNumber {
                pitches.append(pitch.octaveShifted(by: 1))
            } else {
                pitches.append(pitch)
            }
        }

        if inversion > 0 {
            for pitchIndex in 0..<inversion {
                pitches[pitchIndex] = pitches[pitchIndex].octaveShifted(by: 1)
            }
        } else if inversion < 0 {
            pitches = pitches.reversed()
            for pitchIndex in 0..<abs(inversion) {
                pitches[pitchIndex] = pitches[pitchIndex].octaveShifted(by: -1)
            }
        }

        self.pitches = pitches.sorted()
    }
    
    func findClosestInversion(using chordDescriptor: ChordDescriptor) -> Chord {
        let inversionCount = chordDescriptor.keyNames.count-1
        
        var inversionTuples = [(pitchCenterFrequencyDistance: Double, chord: Chord)]()
        for inversion in -inversionCount...inversionCount {
            let inversionChord = Chord(from: chordDescriptor, octave: octave, inversion: inversion)
            let pitchCenterFrequencyDistance = abs(self.pitchCenterFrequency - inversionChord.pitchCenterFrequency)
            inversionTuples.append((pitchCenterFrequencyDistance: pitchCenterFrequencyDistance,
                                    chord: inversionChord) )
        }
        
        let closestInversionTuple = inversionTuples.min {tuple1,tuple2 in
            tuple1.pitchCenterFrequencyDistance < tuple2.pitchCenterFrequencyDistance
        }
        
        return closestInversionTuple!.chord
    }
    
    func randomInversion() -> Chord {
        let inversion = Int.random(in: -(descriptor.keyNames.count-1)...descriptor.keyNames.count-1)
        return .init(from: self.descriptor, octave: self.octave, inversion: inversion)
    }
}

extension Chord: CustomStringConvertible {
    var description: String {
        var pitchStrings = [String]()
        for pitch in pitches {
            pitchStrings.append(pitch.description)
        }
        return "\(pitchStrings.joined(separator: "-")) root:\(root) inv:\(inversion)"
    }
}
