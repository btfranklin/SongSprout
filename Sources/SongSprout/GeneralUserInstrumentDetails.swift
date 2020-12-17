//  Created by B.T. Franklin on 12/27/19.

class GeneralUserInstrumentDetails {
    
    static let shared = GeneralUserInstrumentDetails()
    
    let instrumentDetails: [String:InstrumentDetails]
    
    private init() {
        
        var instrumentDetails = [String:InstrumentDetails]()
        
        var instrumentDetailsItems = Set<InstrumentDetails>()
        instrumentDetailsItems.insert(.init(
            name: "Stereo Grand",
            bank: 0, preset: 0, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Bright Grand",
            bank: 0, preset: 1, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Electric Grand",
            bank: 0, preset: 2, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Honky-Tonk",
            bank: 0, preset: 3, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Tine Electric Piano",
            bank: 0, preset: 4, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Chorused Tine EP",
            bank: 8, preset: 4, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "FM Electric Piano",
            bank: 0, preset: 5, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Chorused FM EP",
            bank: 8, preset: 5, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Harpsichord",
            bank: 0, preset: 6, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Coupled Harpsichord",
            bank: 8, preset: 6, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Clavinet",
            bank: 0, preset: 7, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Celeste",
            bank: 0, preset: 8,
            hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Glockenspiel",
            bank: 0, preset: 9, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Music Box",
            bank: 0, preset: 10, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 5, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Vibraphone",
            bank: 0, preset: 11, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Marimba",
            bank: 0, preset: 12, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Xylophone",
            bank: 0, preset: 13, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 1, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Tubular Bells",
            bank: 0, preset: 14, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Church Bells",
            bank: 8, preset: 14, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Dulcimer",
            bank: 0, preset: 15, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Tonewheel Organ",
            bank: 0, preset: 16, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Detuned Tnwl. Organ",
            bank: 8, preset: 16, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Percussive Organ",
            bank: 0, preset: 17, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Detuned Perc. Organ",
            bank: 8, preset: 17, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Rock Organ",
            bank: 0, preset: 18, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Pipe Organ",
            bank: 0, preset: 19, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 1, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Pipe Organ 2",
            bank: 8, preset: 19, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 1, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Reed Organ",
            bank: 0, preset: 20, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Accordian",
            bank: 0, preset: 21, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Harmonica",
            bank: 0, preset: 22, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 5, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Bandoneon",
            bank: 0, preset: 23, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Nylon Guitar",
            bank: 0, preset: 24, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Steel Guitar",
            bank: 0, preset: 25, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Jazz Guitar",
            bank: 0, preset: 26, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Clean Guitar",
            bank: 0, preset: 27, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Muted Guitar",
            bank: 0, preset: 28, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Overdrive Guitar",
            bank: 0, preset: 29, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Distortion Guitar",
            bank: 0, preset: 30, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Guitar Harmonics",
            bank: 0, preset: 31, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 5, recommendedHighOctave: 5))
        instrumentDetailsItems.insert(.init(
            name: "Acoustic Bass",
            bank: 0, preset: 32, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 4))
        instrumentDetailsItems.insert(.init(
            name: "Finger Bass",
            bank: 0, preset: 33, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 4))
        instrumentDetailsItems.insert(.init(
            name: "Pick Bass",
            bank: 0, preset: 34, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 4))
        instrumentDetailsItems.insert(.init(
            name: "Fretless Bass",
            bank: 0, preset: 35, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 4))
        instrumentDetailsItems.insert(.init(
            name: "Slap Bass 1",
            bank: 0, preset: 36, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 4))
        instrumentDetailsItems.insert(.init(
            name: "Slap Bass 2",
            bank: 0, preset: 37, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 4))
        instrumentDetailsItems.insert(.init(
            name: "Synth Bass 1",
            bank: 0, preset: 38, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 4))
        instrumentDetailsItems.insert(.init(
            name: "Synth Bass 101",
            bank: 1, preset: 38, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 5))
        instrumentDetailsItems.insert(.init(
            name: "Synth Bass 2",
            bank: 0, preset: 39, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 4))
        instrumentDetailsItems.insert(.init(
            name: "Violin",
            bank: 0, preset: 40, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Viola",
            bank: 0, preset: 41, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Cello",
            bank: 0, preset: 42, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Double Bass",
            bank: 0, preset: 43, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Stereo Strings Trem",
            bank: 0, preset: 44, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 7))
// DISABLED because the stereo version is fine
//        instrumentDetailsItems.insert(.init(
//            name: "Mono Strings Trem",
//            bank: 1, preset: 44, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Pizzicato Strings",
            bank: 0, preset: 45, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Orchestral Harp",
            bank: 0, preset: 46, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Timpani",
            bank: 0, preset: 47, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 3))
        instrumentDetailsItems.insert(.init(
            name: "Stereo Strings Fast",
            bank: 0, preset: 48, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 7))
// DISABLED because the stereo version is fine
//        instrumentDetailsItems.insert(.init(
//            name: "Mono Strings Fast",
//            bank: 1, preset: 48, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Stereo Strings Slow",
            bank: 0, preset: 49, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 3, recommendedHighOctave: 7))
// DISABLED because the stereo version is fine
//        instrumentDetailsItems.insert(.init(
//            name: "Mono Strings Slow",
//            bank: 1, preset: 49, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 3, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Synth Strings 1",
            bank: 0, preset: 50, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Synth Strings 2",
            bank: 0, preset: 51, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 2, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Concert Choir",
            bank: 0, preset: 52, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
// DISABLED because the stereo version is fine
//        instrumentDetailsItems.insert(.init(
//            name: "Concert Choir Mono",
//            bank: 1, preset: 52, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Voice Oohs",
            bank: 0, preset: 53, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Synth Voice",
            bank: 0, preset: 54, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 5))
        instrumentDetailsItems.insert(.init(
            name: "Orchestra Hit",
            bank: 0, preset: 55, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 5, recommendedHighOctave: 5))
        instrumentDetailsItems.insert(.init(
            name: "Trumpet",
            bank: 0, preset: 56, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Trumpet 2",
            bank: 1, preset: 56, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Trombone",
            bank: 0, preset: 57, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Trombone 2",
            bank: 1, preset: 57, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Tuba",
            bank: 0, preset: 58, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 5))
        instrumentDetailsItems.insert(.init(
            name: "Muted Trumpet",
            bank: 0, preset: 59, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Muted Trumpet 2",
            bank: 1, preset: 59, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "French Horns",
            bank: 0, preset: 60, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Solo French Horn",
            bank: 1, preset: 60, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Brass Section",
            bank: 0, preset: 61, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
// DISABLED because the stereo version is fine
//        instrumentDetailsItems.insert(.init(
//            name: "Brass Section Mono",
//            bank: 1, preset: 61, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Synth Brass 1",
            bank: 0, preset: 62, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Synth Brass 2",
            bank: 0, preset: 63, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Soprano Sax",
            bank: 0, preset: 64, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 5, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Alto Sax",
            bank: 0, preset: 65, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Tenor Sax",
            bank: 0, preset: 66, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 5))
        instrumentDetailsItems.insert(.init(
            name: "Baritone Sax",
            bank: 0, preset: 67, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 5))
        instrumentDetailsItems.insert(.init(
            name: "Oboe",
            bank: 0, preset: 68, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "English Horn",
            bank: 0, preset: 69, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Bassoon",
            bank: 0, preset: 70, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Clarinet",
            bank: 0, preset: 71, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Piccolo",
            bank: 0, preset: 72, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 5, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Flute",
            bank: 0, preset: 73, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 5, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Recorder",
            bank: 0, preset: 74, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 5, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Pan Flute",
            bank: 0, preset: 75, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Bottle Blow",
            bank: 0, preset: 76, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 4))
        instrumentDetailsItems.insert(.init(
            name: "Shakuhachi",
            bank: 0, preset: 77, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 5, recommendedHighOctave: 5))
        instrumentDetailsItems.insert(.init(
            name: "Irish Tin Whistle",
            bank: 0, preset: 78, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 6, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Ocarina",
            bank: 0, preset: 79, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 5, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Square Lead",
            bank: 0, preset: 80, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Square Wave",
            bank: 1, preset: 80, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Saw Lead",
            bank: 0, preset: 81, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Saw Wave",
            bank: 1, preset: 81, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Synth Calliope",
            bank: 0, preset: 82, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Chiffer Lead",
            bank: 0, preset: 83, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        // PROBLEM NOTE: Sustain loop isn't working, attributes updated to reflect that
        instrumentDetailsItems.insert(.init(
            name: "Charang",
            bank: 0, preset: 84, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Solo Vox",
            bank: 0, preset: 85, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "5th Saw Wave",
            bank: 0, preset: 86, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Bass & Lead",
            bank: 0, preset: 87, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Fantasia",
            bank: 0, preset: 88, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Warm Pad",
            bank: 0, preset: 89, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Polysynth",
            bank: 0, preset: 90, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Space Voice",
            bank: 0, preset: 91, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Bowed Glass",
            bank: 0, preset: 92, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 3, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Metal Pad",
            bank: 0, preset: 93, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Halo Pad",
            bank: 0, preset: 94, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 2, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Sweep Pad",
            bank: 0, preset: 95, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Ice Rain",
            bank: 0, preset: 96, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
// DISABLED because the stereo effect seems to freak the synth out
//        instrumentDetailsItems.insert(.init(
//            name: "Soundtrack",
//            bank: 0, preset: 97, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 3, recommendedHighOctave: 5))
        instrumentDetailsItems.insert(.init(
            name: "Crystal",
            bank: 0, preset: 98, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 5, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Synth Mallet",
            bank: 1, preset: 98, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Atmosphere",
            bank: 0, preset: 99, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Brightness",
            bank: 0, preset: 100, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
        instrumentDetailsItems.insert(.init(
            name: "Goblin",
            bank: 0, preset: 101, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Echo Drops",
            bank: 0, preset: 102, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Star Theme",
            bank: 0, preset: 103, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Sitar",
            bank: 0, preset: 104, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Banjo",
            bank: 0, preset: 105, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Shamisen",
            bank: 0, preset: 106, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Koto",
            bank: 0, preset: 107, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Kalimba",
            bank: 0, preset: 108, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 7))
// DISABLED because this instrument needs special tracking. Cool if it works, though.
//        instrumentDetailsItems.insert(.init(
//            name: "Bagpipes",
//            bank: 0, preset: 109, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Fiddle",
            bank: 0, preset: 110, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Shenai",
            bank: 0, preset: 111, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Tinker Bell",
            bank: 0, preset: 112, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 6, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Agogo",
            bank: 0, preset: 113, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Steel Drums",
            bank: 0, preset: 114, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Wood Block",
            bank: 0, preset: 115, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 6))
        instrumentDetailsItems.insert(.init(
            name: "Taiko Drum",
            bank: 0, preset: 116, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 4))
        instrumentDetailsItems.insert(.init(
            name: "Melodic Tom",
            bank: 0, preset: 117, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 8))
        instrumentDetailsItems.insert(.init(
            name: "Synth Drum",
            bank: 0, preset: 118, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 8))
// DISABLED because these are all special effects
//        instrumentDetailsItems.insert(.init(
//            name: "Reverse Cymbal",
//            bank: 0, preset: 119, hasContinuousSustain: false, hasFastAttack: false, recommendedLowOctave: 4, recommendedHighOctave: 6))
//        instrumentDetailsItems.insert(.init(
//            name: "Fret Noise",
//            bank: 0, preset: 120, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 5))
//        instrumentDetailsItems.insert(.init(
//            name: "Breath Noise",
//            bank: 0, preset: 121, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 5))
//        instrumentDetailsItems.insert(.init(
//            name: "Seashore",
//            bank: 0, preset: 122, hasContinuousSustain: false, hasFastAttack: false, recommendedLowOctave: 3, recommendedHighOctave: 6))
//        instrumentDetailsItems.insert(.init(
//            name: "Howling Winds",
//            bank: 3, preset: 122, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 4, recommendedHighOctave: 6))
//        instrumentDetailsItems.insert(.init(
//            name: "Stream",
//            bank: 4, preset: 122, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 4, recommendedHighOctave: 6))
//        instrumentDetailsItems.insert(.init(
//            name: "Bubbles",
//            bank: 5, preset: 122, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 6))
//        instrumentDetailsItems.insert(.init(
//            name: "Birds",
//            bank: 0, preset: 123, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 2, recommendedHighOctave: 7))
//        instrumentDetailsItems.insert(.init(
//            name: "Bird 2",
//            bank: 3, preset: 123, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 3, recommendedHighOctave: 4))
//        instrumentDetailsItems.insert(.init(
//            name: "Scratch",
//            bank: 4, preset: 123, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 5))
//        instrumentDetailsItems.insert(.init(
//            name: "Telephone 1",
//            bank: 0, preset: 124, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 5))
//        instrumentDetailsItems.insert(.init(
//            name: "Windchime",
//            bank: 5, preset: 124, hasContinuousSustain: true, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 7))
//        instrumentDetailsItems.insert(.init(
//            name: "Helicopter",
//            bank: 0, preset: 125, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 5, recommendedHighOctave: 5))
//        instrumentDetailsItems.insert(.init(
//            name: "Siren",
//            bank: 5, preset: 125, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 4, recommendedHighOctave: 5))
//        instrumentDetailsItems.insert(.init(
//            name: "Train",
//            bank: 6, preset: 125, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 2, recommendedHighOctave: 5))
//        instrumentDetailsItems.insert(.init(
//            name: "Jet Plane",
//            bank: 7, preset: 125, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 5, recommendedHighOctave: 6))
//        instrumentDetailsItems.insert(.init(
//            name: "Applause",
//            bank: 0, preset: 126, hasContinuousSustain: true, hasFastAttack: false, recommendedLowOctave: 5, recommendedHighOctave: 5))
//        instrumentDetailsItems.insert(.init(
//            name: "Heart Beat",
//            bank: 4, preset: 126, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 5))
//        instrumentDetailsItems.insert(.init(
//            name: "Footsteps",
//            bank: 5, preset: 126, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 2, recommendedHighOctave: 5))
//        instrumentDetailsItems.insert(.init(
//            name: "Gun Shot",
//            bank: 0, preset: 127, hasContinuousSustain: false, hasFastAttack: true, recommendedLowOctave: 4, recommendedHighOctave: 4))

        for item in instrumentDetailsItems {
            instrumentDetails[item.name] = item
        }
        
        self.instrumentDetails = instrumentDetails
    }
    
}
