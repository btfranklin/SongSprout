//  Created by B.T. Franklin on 4/20/20.

import AudioKit

struct LeadTrackDefinition: TrackDefinition {
    
    let identifier: PartIdentifier = .lead
    let volume = Volume(0.6)

    let genotype: LeadPartGenotype
    
    init(for genotype: LeadPartGenotype) {
        self.genotype = genotype
    }

    func createNode() -> Node {
        let accompaniment = MIDISampler(name: identifier.rawValue)
        do {
            let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[genotype.instrumentName]!
            try accompaniment.loadSoundFont(GLOBAL_SOUNDFONT_NAME,
                                            preset: instrument.preset,
                                            bank: instrument.bank,
                                            in: .module)
        } catch {
            print("Error while loading Sound Font in LeadTrackDefinition: \(error)")
        }
        return accompaniment
    }
    
}
