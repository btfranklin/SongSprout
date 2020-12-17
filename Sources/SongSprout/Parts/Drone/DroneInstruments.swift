//  Created by B.T. Franklin on 2/19/20.

class DroneInstruments {
    
    static let shared = DroneInstruments()
    
    let instrumentNames: [String]
    
    private init() {
        self.instrumentNames = [
            "Tonewheel Organ",
            "Detuned Tnwl. Organ",
            "Percussive Organ",
            "Detuned Perc. Organ",
            "Rock Organ",
            "Pipe Organ",
            "Pipe Organ 2",
            "Stereo Strings Trem",
            "Stereo Strings Fast",
            "Stereo Strings Slow",
            "Synth Strings 1",
            "Solo Vox",
            "Bass & Lead",
            "Warm Pad",
            "Polysynth",
            "Halo Pad",
            "Sweep Pad",
            "Ice Rain",
            "Atmosphere",
            "Goblin",
            "Echo Drops",
            "Star Theme",
        ]
    }
    
}

