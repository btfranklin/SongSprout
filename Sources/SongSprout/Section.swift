//  Created by B.T. Franklin on 12/22/19.

import AudioKit

class Section {
    
    let descriptor: SectionDescriptor
    let chordFunctionCategorySequence: ChordFunctionCategorySequence
    let chordProgression: ChordProgression
    let chordPlacementMapPerPhrase: ChordPlacementMap
    let measureCount: Int
    
    var duration: Duration {
        .init(beats: Double(measureCount) * SectionDescriptor.MEASURE_DURATION.beats)
    }

    var composedPartSections: [ComposedPartSection]
    
    init(descriptor: SectionDescriptor, in song: Song) {
        self.descriptor = descriptor
        self.composedPartSections = [ComposedPartSection]()
        self.measureCount = descriptor.measuresInPhrase * descriptor.phraseCount
        
        if SectionDescriptor.NORMAL_DESIGNATIONS.contains(descriptor.designation) {
            self.chordFunctionCategorySequence = song.genotype.chordFunctionCategorySequences.randomElement()!
        } else {
            self.chordFunctionCategorySequence = .init(length: 1)
        }
        
        self.chordPlacementMapPerPhrase = ChordPlacementMap(chordCount: self.chordFunctionCategorySequence.chordFunctionCategories.count,
                                                            measureCount: descriptor.measuresInPhrase,
                                                            measureDuration: SectionDescriptor.MEASURE_DURATION)
        self.chordProgression = ChordProgression(chordFunctionCategorySequence: self.chordFunctionCategorySequence,
                                                 scale: song.scale,
                                                 key: song.key)
    }
    
    func composeParts(in song: Song) {
        switch self.descriptor.designation {
        case .i:
            composeIntro(in: song)
        case .f:
            composeFinale(in: song)
        case .b:
            composeBreak(in: song)
        default:
            composeNormal(in: song, with: self.descriptor.density)
        }
    }
    
    private func composeIntro(in song: Song) {
        // TODO Generate intros for all relevant parts
        if let partGenotype = song.genotype.dronePartGenotype {
            let composer = DronePartComposer(for: self, in: song, using: partGenotype)
            composedPartSections.append(composer.composeIntro())
        }
        
        if let partGenotype = song.genotype.drumsPartGenotype {
            let composer = DrumsPartComposer(for: self, in: song, using: partGenotype)
            composedPartSections.append(composer.composeIntro())
        }
        
        // bass

        if let partGenotype = song.genotype.leadPartGenotype {
            let composer = LeadPartComposer(for: self, in: song, using: partGenotype)
            composedPartSections.append(composer.composeIntro())
        }
        
        if let partGenotype = song.genotype.accompanimentPartGenotype {
            let composer = AccompanimentPartComposer(for: self, in: song, using: partGenotype)
            composedPartSections.append(composer.composeIntro())
        }
        
        // taiko?
        
    }
    
    private func composeFinale(in song: Song) {
        
        // Determine what parts were used in the last non-finale section, and use those in the finale
        let lastNonFinaleSectionDescriptor = song.sectionDescriptors.last(where: {descriptor in
            descriptor.designation != .f
        })!
        let lastNonFinaleSection = song.sectionsByDesignation[lastNonFinaleSectionDescriptor.designation]!
        let lastComposedPartIdentifiers = lastNonFinaleSection.composedPartSections.map { composedPartSection in
            composedPartSection.partIdentifier
        }

        if lastComposedPartIdentifiers.contains(.drone), let partGenotype = song.genotype.dronePartGenotype {
            let composer = DronePartComposer(for: self, in: song, using: partGenotype)
            composedPartSections.append(composer.composeFinale())
        }

        if lastComposedPartIdentifiers.contains(.drums), let partGenotype = song.genotype.drumsPartGenotype {
            let composer = DrumsPartComposer(for: self, in: song, using: partGenotype)
            composedPartSections.append(composer.composeFinale())
        }

        if lastComposedPartIdentifiers.contains(.bass), let partGenotype = song.genotype.bassPartGenotype {
            let composer = BassPartComposer(for: self, in: song, using: partGenotype)
            composedPartSections.append(composer.composeFinale())
        }

        if lastComposedPartIdentifiers.contains(.lead), let partGenotype = song.genotype.leadPartGenotype {
            let composer = LeadPartComposer(for: self, in: song, using: partGenotype)
            composedPartSections.append(composer.composeFinale())
        }

        if lastComposedPartIdentifiers.contains(.accompaniment), let partGenotype = song.genotype.accompanimentPartGenotype {
            let composer = AccompanimentPartComposer(for: self, in: song, using: partGenotype)
            composedPartSections.append(composer.composeFinale())
        }
        
        if lastComposedPartIdentifiers.contains(.pad), let partGenotype = song.genotype.padPartGenotype {
            let composer = PadPartComposer(for: self, in: song, using: partGenotype)
            composedPartSections.append(composer.composeFinale())
        }
    }
    
    private func composeBreak(in song: Song) {
        
        var partIdentifiers = song.genotype.partIdentifiers
        
        // Remove part identifiers that cannot have breaks
        partIdentifiers.removeAll(where: {partIdentifier in
            partIdentifier == PartIdentifier.drone || partIdentifier == .arpeggiator || partIdentifier == .pad
        })
        
        // TODO temporarily remove unsupported parts
//        partIdentifiers.removeAll(where: {partIdentifier in
//            partIdentifier == PartIdentifier.accompaniment || partIdentifier == PartIdentifier.lead || partIdentifier == PartIdentifier.bass
//        })
        
        // TODO Sometimes this is empty...wtf
        let partIdentifier = partIdentifiers.randomElement()!
        switch partIdentifier {
        case .drums:
            if let partGenotype = song.genotype.drumsPartGenotype {
                let composer = DrumsPartComposer(for: self, in: song, using: partGenotype)
                composedPartSections.append(composer.composeSolo())
            }
        case .accompaniment:
            // TODO add breaks for accompaniment
            break
        case .lead:
            // TODO add breaks for lead
            break
        case .bass:
            // TODO add breaks for bass
            break
        default:
            fatalError("Unsupported part identifier tried to compose a break: \(partIdentifier)")
        }
    }

    private func composeNormal(in song: Song, with density: SectionDescriptor.Density) {
                
        var partIdentifiersPendingComposition = song.genotype.partIdentifiers
        
        // Parts that occur if present for all densities
        if let partGenotype = song.genotype.dronePartGenotype {
            let composer = DronePartComposer(for: self, in: song, using: partGenotype)
            composedPartSections.append(composer.composeNormal())
            partIdentifiersPendingComposition.removeAll(where: {$0 == .drone})
        }
        
        if let partGenotype = song.genotype.drumsPartGenotype {
            let composer = DrumsPartComposer(for: self, in: song, using: partGenotype)
            composedPartSections.append(composer.composeNormal())
            partIdentifiersPendingComposition.removeAll(where: {$0 == .drums})
        }
        
        if let partGenotype = song.genotype.bassPartGenotype {
            let composer = BassPartComposer(for: self, in: song, using: partGenotype)
            composedPartSections.append(composer.composeNormal())
            partIdentifiersPendingComposition.removeAll(where: {$0 == .bass})
        }
        
        // Parts that are selected additively for increasing densities
        var additionalPartsForCurrentSection = partIdentifiersPendingComposition.count / ((density < .complete) ? 2 : 1)
        if additionalPartsForCurrentSection > 0, let partGenotype = song.genotype.leadPartGenotype {
            let composer = LeadPartComposer(for: self, in: song, using: partGenotype)
            composedPartSections.append(composer.composeNormal())
            partIdentifiersPendingComposition.removeAll(where: {$0 == .lead})
            additionalPartsForCurrentSection -= 1
        }
        
        while additionalPartsForCurrentSection > 0 {
            let partToCompose = partIdentifiersPendingComposition.randomElement()!
            
            switch partToCompose {
            case .accompaniment:
                if let partGenotype = song.genotype.accompanimentPartGenotype {
                    let composer = AccompanimentPartComposer(for: self, in: song, using: partGenotype)
                    composedPartSections.append(composer.composeNormal())
                }

            case .pad:
                if let partGenotype = song.genotype.padPartGenotype {
                    let composer = PadPartComposer(for: self, in: song, using: partGenotype)
                    composedPartSections.append(composer.composeNormal())
                }

            case .arpeggiator:
                if let partGenotype = song.genotype.arpeggiatorPartGenotype {
                    let composer = ArpeggiatorPartComposer(for: self, in: song, using: partGenotype)
                    composedPartSections.append(composer.composeNormal())
                }
                
            default:
                fatalError("Part slipped through that shouldn't have been possible: \(partToCompose)")
            }
            
            partIdentifiersPendingComposition.removeAll(where: {$0 == partToCompose})
            additionalPartsForCurrentSection -= 1
        }
    }
    
    func populateTracks(in song: Song, from offset: Duration) {
        for composedPartSection in composedPartSections {
            let partIdentifier = composedPartSection.partIdentifier
            composedPartSection.populate(track: song.tracksByIdentifier[partIdentifier]!, from: offset)
        }
    }
}
