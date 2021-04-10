//  Created by B.T. Franklin on 4/9/21.

import AudioKit

protocol SignalToMixerRouteConnector {

    var identifier: PartIdentifier { get }
    var volume: Volume { get }

    func connectRoute(from signalNode: Node, to mixerNode: Mixer)
}

extension SignalToMixerRouteConnector {

    func connectRoute(from signalNode: Node, to mixerNode: Mixer) {
        let compressor = Compressor(signalNode)
        let localMixer = Mixer(compressor, name: "\(self.identifier.rawValue) Mixer")
        localMixer.volume = self.volume.mixerValue
        mixerNode.addInput(localMixer)
    }

}
