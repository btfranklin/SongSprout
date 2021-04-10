//  Created by B.T. Franklin on 12/24/19.

import AudioKit

struct ArpeggiatorTrackDefinition: TrackNodeProducer, SignalToMixerRouteConnector {
    
    let identifier: PartIdentifier = .arpeggiator
    let volume = Volume(0.5)

    let genotype: ArpeggiatorPartGenotype
    
    init(for genotype: ArpeggiatorPartGenotype) {
        self.genotype = genotype
    }
    
    func makeNode() -> Node {
        let arpeggiator = MIDISampler(name: identifier.rawValue)
        do {
            let instrument = GeneralUserInstrumentDetails.shared.instrumentDetails[genotype.instrumentName]!
            try arpeggiator.loadSoundFont(GLOBAL_SOUNDFONT_NAME,
                                          preset: instrument.preset,
                                          bank: instrument.bank,
                                          in: .module)
        } catch {
            print("Error while loading Sound Font in ArpeggiatorTrackDefinition: \(error)")
        }
        return arpeggiator
    }
}
