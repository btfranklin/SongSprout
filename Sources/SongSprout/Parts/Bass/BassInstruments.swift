//  Created by B.T. Franklin on 1/8/20.

class BassInstruments {
    
    static let shared = BassInstruments()
    
    let instrumentNames: [String]
    
    private init() {
        self.instrumentNames = [
            "Acoustic Bass",
            "Finger Bass",
            "Pick Bass",
            "Fretless Bass",
            // DISABLED because they don't work for some reason
            //"Slap Bass 1",
            //"Slap Bass 2",
            //"Synth Bass 1",
            //"Synth Bass 101",
            "Synth Bass 2",
            // DISABLED because it works but sounds wrong with rapid notes
            //"Double Bass",
            "Bass & Lead",
            "Polysynth",
            "Brightness",
        ]
    }
    
}
