//  Created by B.T. Franklin on 2/19/20.

public struct DronePartGenotype: Codable {
    
    // Structural
    public let instrumentName: String
    public let octave: Int
    
    public init(instrumentName: String,
                octave: Int) {
        self.instrumentName = instrumentName
        self.octave = octave
    }
    
    public init() {
        self.instrumentName = DroneInstruments.shared.instrumentNames.randomElement()!
        let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[instrumentName]!
        
        self.octave = instrument.recommendedLowOctave
    }
    
}
