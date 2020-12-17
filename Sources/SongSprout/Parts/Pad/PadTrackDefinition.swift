//  Created by B.T. Franklin on 12/20/19.

import AudioKit

struct PadTrackDefinition: TrackDefinition {
    
    let genotype: PadPartGenotype
    
    let identifier: PartIdentifier = .pad

    init(for genotype: PadPartGenotype) {
        self.genotype = genotype
    }
    
    func createNode() -> Node {
        let pad = MIDISampler(name: "Pad")
        do {
            let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[genotype.instrumentName]!
            try pad.loadSoundFont(GLOBAL_SOUNDFONT_NAME,
                                  preset: instrument.preset,
                                  bank: instrument.bank)
        } catch {
            print("Error while loading Sound Font in PadTrackDefinition: \(error)")
        }
        return pad
    }
    
    func createRoute(from signalNode: Node, to mixerNode: Mixer) {
        let compressor = Compressor(signalNode)
        let localMixer = Mixer(compressor, name: "Pad Mixer")
        localMixer.volume = Volume(userValue: 0.4).mixerValue
        mixerNode.addInput(localMixer)
    }
    
}
