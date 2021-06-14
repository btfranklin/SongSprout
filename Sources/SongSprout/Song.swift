//  Created by B.T. Franklin on 12/11/19.

import AudioKit
import AudioKitEX

class Song {
    
    let genotype: MusicalGenotype
    let key: MusicalKeyName
    let scale: MusicalScale
    let sectionDescriptors: [SectionDescriptor]
    
    let drumsPartContext: DrumsPartSongContext?
    
    var tracksByIdentifier: [PartIdentifier: SequencerTrack] = [:]
    var sectionsByDesignation: [SectionDescriptor.Designation : Section] = [:]
    
    lazy var trackNodeProducers: [TrackNodeProducer] = {
        var trackNodeProducers: [TrackNodeProducer] = []
        
        for partIdentifier in genotype.partIdentifiers {
            switch partIdentifier {
            case .drums:
                trackNodeProducers.append(DrumsTrackDefinition(for: genotype.drumsPartGenotype!))
            case .accompaniment:
                trackNodeProducers.append(AccompanimentTrackDefinition(for: genotype.accompanimentPartGenotype!))
            case .lead:
                trackNodeProducers.append(LeadTrackDefinition(for: genotype.leadPartGenotype!))
            case .bass:
                trackNodeProducers.append(BassTrackDefinition(for: genotype.bassPartGenotype!))
            case .pad:
                trackNodeProducers.append(PadTrackDefinition(for: genotype.padPartGenotype!))
            case .arpeggiator:
                trackNodeProducers.append(ArpeggiatorTrackDefinition(for: genotype.arpeggiatorPartGenotype!))
            case .drone:
                trackNodeProducers.append(DroneTrackDefinition(for: genotype.dronePartGenotype!))
            }
        }
        
        return trackNodeProducers
    }()
    
    init(genotype: MusicalGenotype) {
        self.genotype = genotype
        
        key = MusicalKeyName.allCases.randomElement()!
        scale = MusicalScale(scaleType: genotype.scaleType, key: key)
        
        sectionDescriptors = genotype.flowPattern.convertedIntoSectionDescriptors()
        
        if let partGenotype = genotype.drumsPartGenotype {
            self.drumsPartContext = DrumsPartSongContext(partGenotype)
        } else {
            self.drumsPartContext = nil
        }
    }

    func makeNodesAndTracks(to mixer: Mixer, in sequencer: Sequencer) {
        for trackNodeProducer in trackNodeProducers {
            let trackNode = trackNodeProducer.makeNode()

            if let trackRouteConnector = trackNodeProducer as? SignalToMixerRouteConnector {
                trackRouteConnector.connectRoute(from: trackNode, to: mixer)

                let track = sequencer.addTrack(for: trackNode)
                tracksByIdentifier[trackNodeProducer.identifier] = track
            }
        }
    }
    
    func populateTracks() {
        
        createSections()
        composePartsInSections()
        
        var offset: Duration = .init(beats: 0)
        for sectionDescriptor in sectionDescriptors {
            let section = sectionsByDesignation[sectionDescriptor.designation]!
            section.populateTracks(in: self, from: offset)
            offset += section.duration
        }
        
        for track in tracksByIdentifier.values {
            track.length = offset.beats
        }
    }
    
    private func createSections() {
        for sectionDescriptor in sectionDescriptors {
            
            // Create a section for any given designation only once and store it for re-use
            if sectionsByDesignation[sectionDescriptor.designation] == nil {
                let section = Section(descriptor: sectionDescriptor, in: self)
                sectionsByDesignation[sectionDescriptor.designation] = section
            }
        }
    }
    
    private func composePartsInSections() {
        
        // We have to do these in order, partly to ensure that the finale is always done last
        for sectionDesignation in SectionDescriptor.Designation.allCases {
            if let section = sectionsByDesignation[sectionDesignation] {
                // TODO add conditional success here
                section.composeParts(in: self)
            }
        }
    }

}

extension Song {
    var description: String {
        var designators: [String] = []
        for sectionDescriptor in sectionDescriptors {
            designators.append(sectionDescriptor.designation.rawValue)
        }
        return "\(scale) - \(designators.joined())"
    }
}
