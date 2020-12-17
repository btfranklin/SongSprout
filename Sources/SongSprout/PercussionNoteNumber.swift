//  Created by B.T. Franklin on 1/1/20.

import AudioKit

public enum PercussionNoteNumber: MIDINoteNumber, Codable {
            case highQ = 27
    case slap
    case scratchPush
            case scratchPull
    case sticks
            case squareClick
    case metronomeClick
            case metronomeBell
    case kickDrum2
    case kickDrum1
            case sideStick
    case snareDrum1
            case handClap
    case snareDrum2
    case lowTom2
            case closedHiHat
    case lowTom1
            case pedalHiHat
    case midTom2
            case openHiHat
    case midTom1
    case highTom2
            case crashCymbal
    case highTom1
            case rideCymbal
    case chineseCymbal
    case rideBell
            case tambourine
    case splashCymbal
            case cowbell
    case crashCymbal2
            case vibraslap
    case rideCymbal2
    case highBongo
            case lowBongo
    case muteHighConga
            case openHighConga
    case lowConga
    case highTimbale
            case lowTimbale
    case highAgogo
            case lowAgogo
    case cabasa
            case maracas
    case shortHiWhistle
    case longLoWhistle
            case shortGuiro
    case longGuiro
            case claves
    case highWoodBlock
    case lowWoodBlock
            case muteCuica
    case openCuica
            case muteTriangle
    case openTriangle
            case shaker
    case jingleBell
    case bellTree
            case castanets
    case muteSurdo
            case openSurdo
}
