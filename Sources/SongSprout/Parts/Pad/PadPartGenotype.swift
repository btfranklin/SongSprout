//  Created by B.T. Franklin on 1/1/20.

public struct PadPartGenotype: Codable {
    
    // Structural
    public let instrumentName: String
    public let octave: Int
    
    public init(instrumentName: String,
                octave: Int) {
        self.instrumentName = instrumentName
        self.octave = octave
    }

    public init(complexity: Complexity) {
        self.instrumentName = PadInstruments.shared.instrumentNames.randomElement()!
        let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[instrumentName]!
        
        self.octave = (instrument.recommendedLowOctave + instrument.recommendedHighOctave) / 2
    }
    
}
