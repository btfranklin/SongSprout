//  Created by B.T. Franklin on 12/17/19.

import AudioKit

protocol TrackDefinition {
    var identifier: PartIdentifier { get }
    var volume: Volume { get }
    
    func makeNode() -> Node
    func connectRoute(from signalNode: Node, to mixerNode: Mixer)
}

extension TrackDefinition {

    func connectRoute(from signalNode: Node, to mixerNode: Mixer) {
        let compressor = Compressor(signalNode)
        let localMixer = Mixer(compressor, name: "\(identifier.rawValue) Mixer")
        localMixer.volume = self.volume.mixerValue
        mixerNode.addInput(localMixer)
    }

}

let GLOBAL_SOUNDFONT_NAME = "GeneralUser GS v1.471"
