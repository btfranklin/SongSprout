//  Created by B.T. Franklin on 3/2/20.

import AudioKit

struct AccompanimentTrackDefinition: TrackDefinition {
    
    let identifier: PartIdentifier = .accompaniment
    let volume = Volume(0.6)

    let genotype: AccompanimentPartGenotype

    init(for genotype: AccompanimentPartGenotype) {
        self.genotype = genotype
    }
    
    func createNode() -> Node {
        let partSampler = MIDISampler(name: identifier.rawValue)
        do {
            let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[genotype.instrumentName]!
            try partSampler.loadSoundFont(GLOBAL_SOUNDFONT_NAME,
                                          preset: instrument.preset,
                                          bank: instrument.bank,
                                          in: .module)
        } catch {
            print("Error while loading Sound Font in AccompanimentTrackDefinition: \(error)")
        }
        return partSampler
    }
}
