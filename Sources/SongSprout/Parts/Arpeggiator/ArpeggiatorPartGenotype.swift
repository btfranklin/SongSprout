//  Created by B.T. Franklin on 1/1/20.

import DunesailerUtilities

public struct ArpeggiatorPartGenotype: Codable {
    
    // Structural
    public let instrumentName: String
    public let octave: Int
    
    // Stylistic
    public let pitchOrderingStyle: ArpeggioPitchOrderingStyle
    public let noteDurationOptions: [Double]
    public let sequenceLengthOptions: [Int]
    public let followsChords: Bool

    public init(instrumentName: String,
                octave: Int,
                pitchOrderingStyle: ArpeggioPitchOrderingStyle,
                noteDurationOptions: [Double],
                sequenceLengthOptions: [Int],
                followsChords: Bool) {
        self.instrumentName = instrumentName
        self.octave = octave
        self.pitchOrderingStyle = pitchOrderingStyle
        self.noteDurationOptions = noteDurationOptions
        self.sequenceLengthOptions = sequenceLengthOptions
        self.followsChords = followsChords
    }
    
    public init(complexity: Complexity) {
        self.instrumentName = ArpeggioInstruments.shared.instrumentNames.randomElement()!
        let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[instrumentName]!
        
        self.octave = (instrument.recommendedLowOctave + instrument.recommendedHighOctave) / 2
        
        self.pitchOrderingStyle = ArpeggioPitchOrderingStyle.allCases.randomElement()!
        
        let noteDurationOptionCount: Int
        let sequenceLengthOptionCount: Int
        switch complexity {
        case .negligible:
            noteDurationOptionCount = 1
            sequenceLengthOptionCount = 1
        case .veryLow:
            noteDurationOptionCount = Bool.random() ? 1 : 2
            sequenceLengthOptionCount = 1
        case .low:
            noteDurationOptionCount = Bool.random() ? 1 : 2
            sequenceLengthOptionCount = Bool.random() ? 1 : 2
        case .medium:
            noteDurationOptionCount = Int.random(in: 1...3)
            sequenceLengthOptionCount = Bool.random() ? 1 : 2
        case .high:
            noteDurationOptionCount = Int.random(in: 2...4)
            sequenceLengthOptionCount = Bool.random() ? 2 : 3
        case .veryHigh:
            noteDurationOptionCount = Int.random(in: 2...4)
            sequenceLengthOptionCount = Bool.random() ? 2 : 3
        }
        
        let noteDurationOptionPossibilitiesBag = RandomItemBag([
            1.0     :   100,
            0.5     :   100,
            0.33    :    25,
            0.25    :   100,
            0.125   :    10,
        ])
        
        var noteDurationOptions: [Double] = []
        for _ in 1...noteDurationOptionCount {
            let option = noteDurationOptionPossibilitiesBag.randomItem()!
            noteDurationOptionPossibilitiesBag.removeAll(option)
            noteDurationOptions.append(option)
        }
        self.noteDurationOptions = noteDurationOptions
        
        let sequenceLengthOptionPossibilitiesBag = RandomItemBag([
            3   :    50,
            4   :   100,
            8   :   100,
        ])
        
        var sequenceLengthOptions: [Int] = []
        switch self.pitchOrderingStyle {
        case .rootAlternatingAscending, .rootAlternatingDescending:
            sequenceLengthOptions.append(8)
        default:
            for _ in 1...sequenceLengthOptionCount {
                let option = sequenceLengthOptionPossibilitiesBag.randomItem()!
                
                sequenceLengthOptionPossibilitiesBag.removeAll(option)
                sequenceLengthOptions.append(option)
            }
        }
        self.sequenceLengthOptions = sequenceLengthOptions

        self.followsChords = Bool.random()
    }
}
