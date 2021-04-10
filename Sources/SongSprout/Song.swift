//  Created by B.T. Franklin on 12/11/19.

import AudioKit

class Song {
    
    let genotype: MusicalGenotype
    let key: MusicalKeyName
    let scale: MusicalScale
    let sectionDescriptors: [SectionDescriptor]
    
    let drumsPartContext: DrumsPartSongContext?
    
    var tracksByIdentifier: [PartIdentifier: SequencerTrack] = [:]
    var sectionsByDesignation: [SectionDescriptor.Designation : Section] = [:]
    
    lazy var trackDefinitions: [TrackDefinition] = {
        var trackDefinitions: [TrackDefinition] = []
        
        for partIdentifier in genotype.partIdentifiers {
            switch partIdentifier {
            case .drums:
                trackDefinitions.append(DrumsTrackDefinition(for: genotype.drumsPartGenotype!))
            case .accompaniment:
                trackDefinitions.append(AccompanimentTrackDefinition(for: genotype.accompanimentPartGenotype!))
            case .lead:
                trackDefinitions.append(LeadTrackDefinition(for: genotype.leadPartGenotype!))
            case .bass:
                trackDefinitions.append(BassTrackDefinition(for: genotype.bassPartGenotype!))
            case .pad:
                trackDefinitions.append(PadTrackDefinition(for: genotype.padPartGenotype!))
            case .arpeggiator:
                trackDefinitions.append(ArpeggiatorTrackDefinition(for: genotype.arpeggiatorPartGenotype!))
            case .drone:
                trackDefinitions.append(DroneTrackDefinition(for: genotype.dronePartGenotype!))
            }
        }
        
        return trackDefinitions
    }()
    
    init(from genotype: MusicalGenotype) {
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
        for trackDefinition in trackDefinitions {
            let trackNode = trackDefinition.makeNode()
            trackDefinition.connectRoute(from: trackNode, to: mixer)

            let track = sequencer.addTrack(for: trackNode)
            tracksByIdentifier[trackDefinition.identifier] = track
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
