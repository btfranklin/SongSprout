//  Created by B.T. Franklin on 3/2/20.

import AudioKit

struct AccompanimentTrackDefinition: TrackDefinition {
    
    let genotype: AccompanimentPartGenotype
    
    let identifier: PartIdentifier = .accompaniment
    
    init(for genotype: AccompanimentPartGenotype) {
        self.genotype = genotype
    }
    
    func createNode() -> Node {
        let accompaniment = MIDISampler(name: "Accompaniment")
        do {
            let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[genotype.instrumentName]!
            try accompaniment.loadSoundFont(GLOBAL_SOUNDFONT_NAME,
                                            preset: instrument.preset,
                                            bank: instrument.bank)
        } catch {
            print("Error while loading Sound Font in AccompanimentTrackDefinition: \(error)")
        }
        return accompaniment
    }
    
    func createRoute(from signalNode: Node, to mixerNode: Mixer) {
        let compressor = Compressor(signalNode)
        let localMixer = Mixer(compressor, name: "Accompaniment Mixer")
        localMixer.volume = Volume(userValue: 0.6).mixerValue
        mixerNode.addInput(localMixer)
    }
    
}
