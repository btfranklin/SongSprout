//  Created by B.T. Franklin on 1/8/20.

import AudioKit

struct BassTrackDefinition: TrackDefinition {
    
    let genotype: BassPartGenotype
    
    let identifier: PartIdentifier = .bass
    
    init(for genotype: BassPartGenotype) {
        self.genotype = genotype
    }
    
    func createNode() -> Node {
        let bass = MIDISampler(name: "Bass")
        do {
            let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[genotype.instrumentName]!
            try bass.loadSoundFont(GLOBAL_SOUNDFONT_NAME,
                                   preset: instrument.preset,
                                   bank: instrument.bank)
        } catch {
            print("Error while loading Sound Font in BassTrackDefinition: \(error)")
        }
        return bass
    }
    
    func createRoute(from signalNode: Node, to mixerNode: Mixer) {
        let compressor = Compressor(signalNode)
        let localMixer = Mixer(compressor, name: "Bass Mixer")
        localMixer.volume = Volume(userValue: 0.6).mixerValue
        mixerNode.addInput(localMixer)
    }
    
}
