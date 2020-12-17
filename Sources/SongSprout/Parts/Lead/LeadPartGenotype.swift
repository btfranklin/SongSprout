//  Created by B.T. Franklin on 4/20/20.

public struct LeadPartGenotype: Codable {
    
    // Structural
    public let instrumentName: String
    public let octave: Int
    
    // Stylistic
    public let staccatoProbability: Int
    public let motifSplitProbability: Int
    
    public init(instrumentName: String,
                octave: Int,
                staccatoProbability: Int,
                motifSplitProbability: Int) {
        self.instrumentName = instrumentName
        self.octave = octave
        self.staccatoProbability = staccatoProbability
        self.motifSplitProbability = motifSplitProbability
    }
    
    public init(complexity: Complexity) {
        self.instrumentName = LeadInstruments.shared.instrumentNames.randomElement()!
        let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[instrumentName]!
        
        self.octave = (instrument.recommendedLowOctave + instrument.recommendedHighOctave) / 2
        
        self.staccatoProbability = Int.random(in: 0...100)
        self.motifSplitProbability = Int.random(in: 0...100)
    }
    
}
