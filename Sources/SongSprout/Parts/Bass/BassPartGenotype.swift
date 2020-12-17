//  Created by B.T. Franklin on 1/8/20.

public struct BassPartGenotype: Codable {
    
    public enum Style: String, Codable, CaseIterable {
        case triesToFollowDrums
        case followsChordChanges
        case followsMotif
    }
    
    // Structural
    public let instrumentName: String
    public let octave: Int
    
    // Stylistic
    public let style: Style
    public let leadingNoteProbability: Int
    
    public init(instrumentName: String,
                octave: Int,
                style: Style,
                leadingNoteProbability: Int) {
        self.instrumentName = instrumentName
        self.octave = octave
        self.style = style
        self.leadingNoteProbability = leadingNoteProbability
    }

    public init(complexity: Complexity) {
        self.instrumentName = BassInstruments.shared.instrumentNames.randomElement()!
        let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[instrumentName]!
        
        self.octave = instrument.recommendedLowOctave + (Bool.random() ? 0 : 1)
    
// TODO enable this
//        if self.instrument.hasContinuousSustain {
//            self.style = Style.allCases.randomElement()!
//        } else {
//            self.style = Bool.random() ? .triesToFollowDrums : .followsMotif
//        }

        self.style = .triesToFollowDrums
        
        self.leadingNoteProbability = Int.random(in: 0...100)
    }
    
}
