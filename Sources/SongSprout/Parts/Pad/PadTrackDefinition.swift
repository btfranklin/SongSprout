//  Created by B.T. Franklin on 12/20/19.

import AudioKit

struct PadTrackDefinition: TrackDefinition {
    
    let identifier: PartIdentifier = .pad
    let volume = Volume(0.4)

    let genotype: PadPartGenotype
    
    init(for genotype: PadPartGenotype) {
        self.genotype = genotype
    }
    
    func makeNode() -> Node {
        let pad = MIDISampler(name: identifier.rawValue)
        do {
            let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[genotype.instrumentName]!
            try pad.loadSoundFont(GLOBAL_SOUNDFONT_NAME,
                                  preset: instrument.preset,
                                  bank: instrument.bank,
                                  in: .module)
        } catch {
            print("Error while loading Sound Font in PadTrackDefinition: \(error)")
        }
        return pad
    }
}
