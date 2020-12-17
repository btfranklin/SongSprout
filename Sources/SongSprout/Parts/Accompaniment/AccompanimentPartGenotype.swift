//  Created by B.T. Franklin on 3/1/20.

import DunesailerUtilities

public struct AccompanimentPartGenotype: Codable {
    
    static private let phraseStyleProbabilities = ProbabilityGroup<AccompanimentPhrasePatternStyle>([
        .chord              : 20,
        .longChord          : 15,
        .decoratedChord     : 20,
        .arpeggio           : 5,
        .chordPicking       : 5,
        .freeform           : 35,
    ], enforcePercent: true)

    // Structural
    public let instrumentName: String
    public let octave: Int

    // Stylistic
    public let accentProbability: Int
    public let freeformAdditionalChordNoteProbability: Int
    public let phraseStyles: [AccompanimentPhrasePatternStyle]

    public init(instrumentName: String,
                octave: Int,
                accentProbability: Int,
                freeformAdditionalChordNoteProbability: Int,
                phraseStyles: [AccompanimentPhrasePatternStyle]) {
        self.instrumentName = instrumentName
        self.octave = octave
        self.accentProbability = accentProbability
        self.freeformAdditionalChordNoteProbability = freeformAdditionalChordNoteProbability
        self.phraseStyles = phraseStyles
    }
    
    public init(complexity: Complexity) {
        self.instrumentName = AccompanimentInstruments.shared.instrumentNames.randomElement()!
        let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[instrumentName]!
        
        var octave = ((instrument.recommendedLowOctave + instrument.recommendedHighOctave) / 2) - 1
        if octave < instrument.recommendedLowOctave {
            octave = instrument.recommendedLowOctave
        }
        self.octave = octave
        
        self.accentProbability = Int.random(in: 0...99)
        self.freeformAdditionalChordNoteProbability = Int.random(in: 0...100)

        let phraseStyleCount: Int
        switch complexity {
        case .negligible, .veryLow:
            phraseStyleCount = 1
        case .low:
            phraseStyleCount = 2
        case .medium:
            phraseStyleCount = 3
        case .high, .veryHigh:
            phraseStyleCount = 4
        }

        var phraseStyles = Set<AccompanimentPhrasePatternStyle>()
        while phraseStyles.count < phraseStyleCount {
            phraseStyles.insert(AccompanimentPartGenotype.phraseStyleProbabilities.randomItem())
        }
        
        self.phraseStyles = phraseStyles.compactMap { $0 }.sorted(by: {$0.rawValue < $1.rawValue})
    }
    
}
