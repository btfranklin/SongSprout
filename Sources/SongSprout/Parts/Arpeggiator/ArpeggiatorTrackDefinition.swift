//  Created by B.T. Franklin on 12/24/19.

import AudioKit

struct ArpeggiatorTrackDefinition: TrackDefinition {
    
    let genotype: ArpeggiatorPartGenotype
    
    let identifier: PartIdentifier = .arpeggiator
    
    init(for genotype: ArpeggiatorPartGenotype) {
        self.genotype = genotype
    }
    
    func createNode() -> Node {
        let arpeggiator = MIDISampler(name: "Arpeggiator")
        do {
            let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[genotype.instrumentName]!
            try arpeggiator.loadSoundFont(GLOBAL_SOUNDFONT_NAME,
                                          preset: instrument.preset,
                                          bank: instrument.bank)
        } catch {
            print("Error while loading Sound Font in ArpeggiatorTrackDefinition: \(error)")
        }
        return arpeggiator
    }
    
    func createRoute(from signalNode: Node, to mixerNode: Mixer) {
        let compressor = Compressor(signalNode)
        let localMixer = Mixer(compressor, name: "Arpeggiator Mixer")
        localMixer.volume = Volume(userValue: 0.5).mixerValue
        mixerNode.addInput(localMixer)
    }
    
}
