//  Created by B.T. Franklin on 4/20/20.

import AudioKit

struct LeadTrackDefinition: TrackDefinition {
    
    let genotype: LeadPartGenotype
    
    let identifier: PartIdentifier = .lead
    
    init(for genotype: LeadPartGenotype) {
        self.genotype = genotype
    }

    func createNode() -> Node {
        let accompaniment = MIDISampler(name: "Lead")
        do {
            let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[genotype.instrumentName]!
            try accompaniment.loadSoundFont(GLOBAL_SOUNDFONT_NAME,
                                            preset: instrument.preset,
                                            bank: instrument.bank)
        } catch {
            print("Error while loading Sound Font in LeadTrackDefinition: \(error)")
        }
        return accompaniment
    }
    
    func createRoute(from signalNode: Node, to mixerNode: Mixer) {
        let compressor = Compressor(signalNode)
        let localMixer = Mixer(compressor, name: "Lead Mixer")
        localMixer.volume = Volume(userValue: 0.6).mixerValue
        mixerNode.addInput(localMixer)
    }
    
}
