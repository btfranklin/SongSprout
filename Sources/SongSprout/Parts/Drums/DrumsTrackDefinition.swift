//  Created by B.T. Franklin on 12/17/19.

import AudioKit

struct DrumsTrackDefinition: TrackNodeProducer, SignalToMixerRouteConnector {
    
    let identifier: PartIdentifier = .drums
    let volume = Volume(0.7)

    let genotype: DrumsPartGenotype

    init(for genotype: DrumsPartGenotype) {
        self.genotype = genotype
    }
    
    func makeNode() -> Node {
        let drums = MIDISampler(name: identifier.rawValue)
        do {
            try drums.loadPercussiveSoundFont(GLOBAL_SOUNDFONT_NAME,
                                              preset: genotype.drumKitPreset.rawValue,
                                              in: .module)
        } catch {
            print("Error while loading Sound Font in DrumsTrackDefinition: \(error)")
        }
        return drums
    }
    
    func connectRoute(from signalNode: Node, to mixerNode: Mixer) {
        
        let reverb: Node
          
        switch genotype.reverbImplementation {
        case .chowning:
            reverb = ChowningReverb(signalNode)
        case .costello:
            reverb = CostelloReverb(signalNode)
        case .appleReverb:
            reverb = Reverb(signalNode,
                            dryWetMix: 1.0)
        case .zita:
            reverb = ZitaReverb(signalNode,
                                dryWetMix: 1.0)
        }
        
        let dryWetMixer = DryWetMixer(signalNode, reverb, balance: genotype.reverbMix)
        let localMixer = Mixer(dryWetMixer, name: "\(identifier.rawValue) Mixer")
        localMixer.volume = self.volume.mixerValue
        mixerNode.addInput(localMixer)
    }
}
