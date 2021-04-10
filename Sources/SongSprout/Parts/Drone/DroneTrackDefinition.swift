//  Created by B.T. Franklin on 2/19/20.

import AudioKit

struct DroneTrackDefinition: TrackDefinition {
    
    let identifier: PartIdentifier = .drone
    let volume = Volume(0.6)

    let genotype: DronePartGenotype
    
    init(for genotype: DronePartGenotype) {
        self.genotype = genotype
    }
    
    func makeNode() -> Node {
        let drone = MIDISampler(name: identifier.rawValue)
        do {
            let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[genotype.instrumentName]!
            try drone.loadSoundFont(GLOBAL_SOUNDFONT_NAME,
                                    preset: instrument.preset,
                                    bank: instrument.bank,
                                    in: .module)
        } catch {
            print("Error while loading Sound Font in DroneTrackDefinition: \(error)")
        }
        return drone
    }
}
