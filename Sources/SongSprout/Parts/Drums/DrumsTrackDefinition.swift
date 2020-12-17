//  Created by B.T. Franklin on 12/17/19.

import AudioKit

struct DrumsTrackDefinition: TrackDefinition {
    
    let genotype: DrumsPartGenotype

    let identifier: PartIdentifier = .drums
    
    init(for genotype: DrumsPartGenotype) {
        self.genotype = genotype
    }
    
    func createNode() -> Node {
        let drums = MIDISampler(name: "Drums")
        do {
            try drums.loadPercussiveSoundFont(GLOBAL_SOUNDFONT_NAME,
                                              preset: genotype.drumKitPreset.rawValue)
        } catch {
            print("Error while loading Sound Font in DrumsTrackDefinition: \(error)")
        }
        return drums
    }
    
    func createRoute(from signalNode: Node, to mixerNode: Mixer) {
        
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
        let localMixer = Mixer(dryWetMixer, name: "Drums Mixer")
        localMixer.volume = Volume(userValue: 0.7).mixerValue
        mixerNode.addInput(localMixer)
    }
    
}
