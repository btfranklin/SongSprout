//  Created by B.T. Franklin on 2/19/20.

import AudioKit

struct DroneTrackDefinition: TrackDefinition {
    
    let genotype: DronePartGenotype
    
    let identifier: PartIdentifier = .drone
    
    init(for genotype: DronePartGenotype) {
        self.genotype = genotype
    }
    
    func createNode() -> Node {
        let drone = MIDISampler(name: "Drone")
        do {
            let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[genotype.instrumentName]!
            try drone.loadSoundFont(GLOBAL_SOUNDFONT_NAME,
                                    preset: instrument.preset,
                                    bank: instrument.bank)
        } catch {
            print("Error while loading Sound Font in DroneTrackDefinition: \(error)")
        }
        return drone
    }
    
    func createRoute(from signalNode: Node, to mixerNode: Mixer) {
        let compressor = Compressor(signalNode)
        let localMixer = Mixer(compressor, name: "Drone Mixer")
        localMixer.volume = Volume(userValue: 0.6).mixerValue
        mixerNode.addInput(localMixer)
    }
    
}
