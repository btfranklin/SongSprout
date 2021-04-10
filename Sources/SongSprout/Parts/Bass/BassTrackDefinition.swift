//  Created by B.T. Franklin on 1/8/20.

import AudioKit

struct BassTrackDefinition: TrackNodeProducer, SignalToMixerRouteConnector {
    
    let identifier: PartIdentifier = .bass
    let volume = Volume(0.6)

    let genotype: BassPartGenotype
    
    init(for genotype: BassPartGenotype) {
        self.genotype = genotype
    }
    
    func makeNode() -> Node {
        let bass = MIDISampler(name: identifier.rawValue)
        do {
            let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[genotype.instrumentName]!
            try bass.loadSoundFont(GLOBAL_SOUNDFONT_NAME,
                                   preset: instrument.preset,
                                   bank: instrument.bank,
                                   in: .module)
        } catch {
            print("Error while loading Sound Font in BassTrackDefinition: \(error)")
        }
        return bass
    }
}
