//  Created by B.T. Franklin on 4/19/20.

import AudioKit

enum PartChannel: MIDIChannel, CaseIterable {
    case lead = 1
    case accompaniment = 2
    case bass = 5
    case arpeggiator = 7
    case pad = 8
    case drone = 9
    case drums = 10
}
