//  Created by B.T. Franklin on 1/9/20.

import AudioKit

extension Array where Element == MIDINoteData {
    func shifted(by offset: Duration) -> [MIDINoteData] {
        self.map { datum in
            MIDINoteData(noteNumber: datum.noteNumber,
                           velocity: datum.velocity,
                           channel: datum.channel,
                           duration: datum.duration,
                           position: datum.position + offset)
        }
    }
}
