//  Created by B.T. Franklin on 12/22/19.

import AudioKit

struct DrumsPartComposer {
    
    static let NORMAL_VELOCITY = MIDIVelocity(100)
    static let QUIETER_VELOCITY = MIDIVelocity(85)
    static let GHOST_VELOCITY = MIDIVelocity(60)

    private let identifier: PartIdentifier = .drums
    private let channel: PartChannel = .drums
    
    private let section: Section
    private let song: Song
    private let partGenotype: DrumsPartGenotype
    private let context: DrumsPartSongContext
    private let isLowDensitySectionInHighRangeFlow: Bool
    
    init(for section: Section, in song: Song, using partGenotype: DrumsPartGenotype) {
        self.section = section
        self.song = song
        self.partGenotype = partGenotype
        self.context = song.drumsPartContext!
        
        self.isLowDensitySectionInHighRangeFlow = (section.descriptor.density == .minimal) && song.genotype.flowPattern.sectionalDensities.contains(.complete)
    }
    
    func composeNormal() -> ComposedPartSection {
        var midiNoteData = [MIDINoteData]()

        let contextPhraseIndices = context.normalPhrases.randomElement()!
        let phraseMidiNoteData = generateNormalPhraseData(fromContextPhraseMeasureIndices: contextPhraseIndices)
        
        let phraseDuration = section.descriptor.phraseDuration
        var offset: Duration = .init(beats: 0)
        for _ in 0..<section.descriptor.phraseCount {
            midiNoteData.append(contentsOf: phraseMidiNoteData.shifted(by: offset))
            offset += phraseDuration
        }
        
        if Bool.random(probability: partGenotype.fillProbability) {
            let fillDuration = Duration(beats: partGenotype.fillDurations.randomElement()!.rawValue)
            let sectionEndDuration = Duration(beats: Double(section.descriptor.phraseCount) * phraseDuration.beats)
            let fillInsertionPoint = sectionEndDuration - fillDuration
            midiNoteData = midiNoteData.filter { midiNoteDatum in
                midiNoteDatum.position < fillInsertionPoint
            }
            
            let fill = Fill(for: fillDuration.beats,
                            with: song.genotype.complexity,
                            using: self.partGenotype,
                            on: channel,
                            allowSilentGap: isLowDensitySectionInHighRangeFlow)
            midiNoteData.append(contentsOf: fill.midiNoteData.shifted(by: fillInsertionPoint))
        }
        
        return ComposedPartSection(partIdentifier: identifier,
                                   section: section,
                                   midiNoteData: midiNoteData)
    }

    func composeFinale() -> ComposedPartSection {
        var midiNoteData = [MIDINoteData]()
        
        midiNoteData.append(.init(noteNumber: partGenotype.bassDrumGenotype.preset.rawValue,
                                  velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                  channel: channel.rawValue,
                                  duration: SectionDescriptor.MEASURE_DURATION,
                                  position: .init(beats: 0)))
        
        midiNoteData.append(.init(noteNumber: PercussionNoteNumber.crashCymbal.rawValue,
                                  velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                  channel: channel.rawValue,
                                  duration: SectionDescriptor.MEASURE_DURATION,
                                  position: .init(beats: 0)))
        
        midiNoteData.append(.init(noteNumber: PercussionNoteNumber.crashCymbal2.rawValue,
                                  velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                  channel: channel.rawValue,
                                  duration: SectionDescriptor.MEASURE_DURATION,
                                  position: .init(beats: 0)))

        return ComposedPartSection(partIdentifier: identifier,
                                   section: section,
                                   midiNoteData: midiNoteData)
    }

    func composeIntro() -> ComposedPartSection {
        var midiNoteData = [MIDINoteData]()
        
        let phraseMidiNoteData = generateIntroPhraseData()
        
        let phraseDuration = section.descriptor.phraseDuration
        var offset: Duration = .init(beats: 0)
        for _ in 0..<section.descriptor.phraseCount {
            midiNoteData.append(contentsOf: phraseMidiNoteData.shifted(by: offset))
            offset += phraseDuration
        }
        
        return ComposedPartSection(partIdentifier: identifier,
                                   section: section,
                                   midiNoteData: midiNoteData)
    }
    
    func composeSolo() -> ComposedPartSection {
        var midiNoteData = [MIDINoteData]()
        
        var positionCursor: Duration = .init(beats: 0)
        while positionCursor < section.duration {
            let fill = Fill(for: SectionDescriptor.MEASURE_DURATION.beats,
                            with: song.genotype.complexity,
                            using: self.partGenotype,
                            on: channel,
                            allowSilentGap: false)
            midiNoteData.append(contentsOf: fill.midiNoteData.shifted(by: positionCursor))
            positionCursor += SectionDescriptor.MEASURE_DURATION
        }
        
        return ComposedPartSection(partIdentifier: identifier,
                                   section: section,
                                   midiNoteData: midiNoteData)
    }
    
    private func generateNormalPhraseData(fromContextPhraseMeasureIndices contextPhraseMeasureIndices: [Int]) -> [MIDINoteData] {
        var midiNoteData = [MIDINoteData]()
        
        let useRideCymbal = Bool.random(probability: partGenotype.hihatRideGenotype.rideCymbalProbability)
        let shortPreset: PercussionNoteNumber = useRideCymbal ? (Bool.random() ? .rideCymbal : .rideCymbal2) : .closedHiHat
        let rideLongPreset: PercussionNoteNumber = [.rideBell, .rideCymbal, .rideCymbal2].randomElement()!

        var measureOffset: Duration = .init(beats: 0)
        for measureIndex in contextPhraseMeasureIndices {
            let bassDrumMeasure = partGenotype.bassDrumGenotype.measures[measureIndex]
            for placementBeat in bassDrumMeasure {
                midiNoteData.append(.init(noteNumber: partGenotype.bassDrumGenotype.preset.rawValue,
                                          velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                          channel: channel.rawValue,
                                          duration: .init(beats: 1),
                                          position: .init(beats: placementBeat) + measureOffset))
            }

            let snareMeasure = partGenotype.snareDrumGenotype.measures[measureIndex]
            for placementBeat in snareMeasure {
                midiNoteData.append(.init(noteNumber: partGenotype.snareDrumGenotype.preset.rawValue,
                                          velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                          channel: channel.rawValue,
                                          duration: .init(beats: 1),
                                          position: .init(beats: placementBeat) + measureOffset))
            }

            let snareGhostMeasure = partGenotype.snareDrumGenotype.ghostMeasures[measureIndex]
            for placementBeat in snareGhostMeasure {
                midiNoteData.append(.init(noteNumber: partGenotype.snareDrumGenotype.ghostPreset.rawValue,
                                          velocity: DrumsPartComposer.GHOST_VELOCITY,
                                          channel: channel.rawValue,
                                          duration: .init(beats: 1),
                                          position: .init(beats: placementBeat) + measureOffset))
            }

            let shortHihatRideMeasure = partGenotype.hihatRideGenotype.shortNoteMeasures[measureIndex]
            let isShortHihatForm = shortHihatRideMeasure.isNotEmpty
            let longHihatRideMeasure = partGenotype.hihatRideGenotype.longNoteMeasures[measureIndex]
            let longPreset: PercussionNoteNumber
            if isShortHihatForm {
                longPreset = useRideCymbal ? .rideBell : .openHiHat
            } else {
                longPreset = useRideCymbal ? rideLongPreset : .openHiHat
            }

            // TODO incorporate hihat pedal when in ride cymbal mode
            if isShortHihatForm {
                for placement in shortHihatRideMeasure {
                    midiNoteData.append(.init(noteNumber: shortPreset.rawValue,
                                              velocity: DrumsPartComposer.GHOST_VELOCITY,
                                              channel: channel.rawValue,
                                              duration: .init(beats: 0.5),
                                              position: .init(beats: placement) + measureOffset))
                }
            }

            for placement in longHihatRideMeasure {
                midiNoteData.append(.init(noteNumber: longPreset.rawValue,
                                          velocity: DrumsPartComposer.GHOST_VELOCITY,
                                          channel: channel.rawValue,
                                          duration: .init(beats: 0.5),
                                          position: .init(beats: placement) + measureOffset))
            }
            
            // Special case for first beat of phrase
            var startCymbalPlaced = false
            if measureOffset.beats == 0.0 {
                if Bool.random(probability: partGenotype.cymbalGenotype.hitOnPhraseStartProbability) {
                    let noteNumber: PercussionNoteNumber = Bool.random() ? .crashCymbal : .crashCymbal2
                    midiNoteData.append(.init(noteNumber: noteNumber.rawValue,
                                              velocity: DrumsPartComposer.QUIETER_VELOCITY,
                                              channel: channel.rawValue,
                                              duration: .init(beats: 4),
                                              position: .init(beats: 0.0)))
                    startCymbalPlaced = true
                }
            }
            
            let primaryCymbalMeasure = partGenotype.cymbalGenotype.primaryMeasures[measureIndex]
            for placementBeat in primaryCymbalMeasure {
                
                if !startCymbalPlaced || placementBeat != 0.0 {
                    if Bool.random(probability: partGenotype.cymbalGenotype.hitOnPlacementProbability) {
                        let noteNumber: PercussionNoteNumber = Bool.random() ? .crashCymbal : .crashCymbal2
                        midiNoteData.append(.init(noteNumber: noteNumber.rawValue,
                                                  velocity: DrumsPartComposer.QUIETER_VELOCITY,
                                                  channel: channel.rawValue,
                                                  duration: .init(beats: 4),
                                                  position: .init(beats: placementBeat) + measureOffset))
                    }
                }
            }

            let secondaryCymbalMeasure = partGenotype.cymbalGenotype.primaryMeasures[measureIndex]
            for placementBeat in secondaryCymbalMeasure {

                if !startCymbalPlaced || placementBeat != 0.0 {
                    if Bool.random(probability: partGenotype.cymbalGenotype.hitOnPlacementProbability) {
                        let noteNumber: PercussionNoteNumber = context.isDanceKit || Bool.random() ? .splashCymbal : .chineseCymbal
                        midiNoteData.append(.init(noteNumber: noteNumber.rawValue,
                                                  velocity: DrumsPartComposer.QUIETER_VELOCITY,
                                                  channel: channel.rawValue,
                                                  duration: .init(beats: 4),
                                                  position: .init(beats: placementBeat) + measureOffset))
                    }
                }
            }

            measureOffset += SectionDescriptor.MEASURE_DURATION
        }
        
        return midiNoteData
    }
    
    private func generateIntroPhraseData() -> [MIDINoteData] {
        var midiNoteData = [MIDINoteData]()
        
        var measureOffset: Duration = .init(beats: 0)
        for _ in 1...section.measureCount {
            
            if Bool.random() {
                for placementBeat in stride(from: 0, to: SectionDescriptor.MEASURE_DURATION.beats, by: 1.0) {
                    midiNoteData.append(.init(noteNumber: PercussionNoteNumber.sticks.rawValue,
                                              velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                              channel: channel.rawValue,
                                              duration: .init(beats: 1),
                                              position: .init(beats: placementBeat) + measureOffset))
                }
            } else {
                for placementBeat in stride(from: 0, to: SectionDescriptor.MEASURE_DURATION.beats, by: 1.0) {
                    midiNoteData.append(.init(noteNumber: PercussionNoteNumber.pedalHiHat.rawValue,
                                              velocity: DrumsPartComposer.NORMAL_VELOCITY,
                                              channel: channel.rawValue,
                                              duration: .init(beats: 1),
                                              position: .init(beats: placementBeat) + measureOffset))
                }
            }

            measureOffset += SectionDescriptor.MEASURE_DURATION
        }
        
        return midiNoteData
    }

}
