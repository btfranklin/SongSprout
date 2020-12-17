//  Created by B.T. Franklin on 1/5/20.

class PadInstruments {
    
    static let shared = PadInstruments()
    
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
            "Reed Organ",
            "Accordian",
            "Harmonica",
            "Bandoneon",
            "Synth Bass 1",
            "Synth Bass 101",
            "Violin",
            "Viola",
            "Cello",
            "Double Bass",
            "Stereo Strings Trem",
// DISABLED because the stereo version is fine
//          "Mono Strings Trem",
            "Stereo Strings Fast",
// DISABLED because the stereo version is fine
//          "Mono Strings Fast",
            "Stereo Strings Slow",
// DISABLED because the stereo version is fine
//          "Mono Strings Slow",
            "Synth Strings 1",
            "Concert Choir",
// DISABLED because the stereo version is fine
//          "Concert Choir Mono",
            "Voice Oohs",
            "Synth Voice",
            "Trumpet",
            "Trumpet 2",
            "Trombone",
            "Trombone 2",
            "Tuba",
            "Muted Trumpet",
            "Muted Trumpet 2",
            "French Horns",
            "Solo French Horn",
            "Brass Section",
// DISABLED because the stereo version is fine
//          "Brass Section Mono",
            "Synth Brass 1",
            "Synth Brass 2",
            "Soprano Sax",
            "Alto Sax",
            "Tenor Sax",
            "Baritone Sax",
            "Oboe",
            "English Horn",
            "Bassoon",
            "Clarinet",
            "Piccolo",
            "Flute",
            "Recorder",
            "Pan Flute",
            "Bottle Blow",
            "Shakuhachi",
            "Irish Tin Whistle",
            "Ocarina",
            "Synth Calliope",
            "Solo Vox",
            "5th Saw Wave",
            "Bass & Lead",
            "Fantasia",
            "Warm Pad",
            "Polysynth",
            "Space Voice",
            "Bowed Glass",
            "Metal Pad",
            "Halo Pad",
            "Sweep Pad",
            "Ice Rain",
// DISABLED because the stereo effect seems to freak the synth out
//          "Soundtrack",
            "Atmosphere",
            "Brightness",
            "Goblin",
            "Echo Drops",
            "Star Theme",
            "Fiddle",
        ]
    }
    
}
