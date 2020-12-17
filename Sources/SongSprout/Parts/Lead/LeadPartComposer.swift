//  Created by B.T. Franklin on 4/20/20.

import AudioKit
import DunesailerUtilities

struct LeadPartComposer {
    
    private let identifier: PartIdentifier = .lead
    private let channel: PartChannel = .lead
    
    private let section: Section
    private let song: Song
    private let partGenotype: LeadPartGenotype
    private let velocity: MIDIVelocity
    
    init(for section: Section, in song: Song, using partGenotype: LeadPartGenotype) {
        self.section = section
        self.song = song
        self.partGenotype = partGenotype
        self.velocity = 100
    }
    
    func composeNormal() -> ComposedPartSection {
        var midiNoteData = [MIDINoteData]()
        
        let phraseData = composeNormalPhrase()
        for phraseNumber in 0..<section.descriptor.phraseCount {
            let phraseOffset = Duration(beats: Double(phraseNumber) * section.descriptor.phraseDuration.beats)
            for phraseMIDINoteDatum in phraseData {
                midiNoteData.append(.init(noteNumber: phraseMIDINoteDatum.noteNumber,
                                          velocity: phraseMIDINoteDatum.velocity,
                                          channel: phraseMIDINoteDatum.channel,
                                          duration: phraseMIDINoteDatum.duration,
                                          position: phraseMIDINoteDatum.position + phraseOffset))
            }
        }
        
        return ComposedPartSection(partIdentifier: identifier, section: section, midiNoteData: midiNoteData)
    }
    
    func composeIntro() -> ComposedPartSection {
        var midiNoteData = [MIDINoteData]()
        
        let phraseData = composeIntroPhrase()
        for phraseNumber in 0..<section.descriptor.phraseCount {
            let phraseOffset = Duration(beats: Double(phraseNumber) * section.descriptor.phraseDuration.beats)
            for phraseMIDINoteDatum in phraseData {
                midiNoteData.append(.init(noteNumber: phraseMIDINoteDatum.noteNumber,
                                          velocity: phraseMIDINoteDatum.velocity,
                                          channel: phraseMIDINoteDatum.channel,
                                          duration: phraseMIDINoteDatum.duration,
                                          position: phraseMIDINoteDatum.position + phraseOffset))
            }
        }

        return ComposedPartSection(partIdentifier: identifier, section: section, midiNoteData: midiNoteData)
    }
    
    func composeFinale() -> ComposedPartSection {
        var midiNoteData = [MIDINoteData]()
        
        let chordDescriptor = section.chordProgression.chordDescriptors.first!
        let chordPlacement = section.chordPlacementMapPerPhrase.chordPlacements.first!
        
        let chord = Chord(from: chordDescriptor, octave: partGenotype.octave)
        
        let finalNoteBeats = [1.0, 2.0, SectionDescriptor.MEASURE_DURATION.beats].randomElement()!
        
        midiNoteData.append(.init(noteNumber: chord.root.midiNoteNumber,
                                  velocity: self.velocity,
                                  channel: channel.rawValue,
                                  duration: .init(beats: finalNoteBeats),
                                  position: chordPlacement.position))
        
        return ComposedPartSection(partIdentifier: identifier, section: section, midiNoteData: midiNoteData)
    }
    
    private func composeIntroPhrase() -> [MIDINoteData] {
        var midiNoteData = [MIDINoteData]()

        var firstChord: Chord?
        for chordIndex in 0..<section.chordProgression.chordDescriptors.count {
            
            let chordDescriptor = section.chordProgression.chordDescriptors[chordIndex]
            let chordPlacement = section.chordPlacementMapPerPhrase.chordPlacements[chordIndex]
            
            let chord: Chord
            if let firstChord = firstChord {
                chord = firstChord.findClosestInversion(using: chordDescriptor)
                
            } else {
                chord = Chord(from: chordDescriptor, octave: partGenotype.octave)
                firstChord = chord
            }
            
            midiNoteData.append(.init(noteNumber: chord.pitches[0].midiNoteNumber,
                                      velocity: self.velocity,
                                      channel: channel.rawValue,
                                      duration: chordPlacement.duration,
                                      position: chordPlacement.position))
        }
        
        return midiNoteData
    }
    
    private func composeNormalPhrase() -> [MIDINoteData] {
        var midiNoteData = [MIDINoteData]()
        
        let pitches = song.scale.pitches(fromOctave: partGenotype.octave-1, toOctave: partGenotype.octave+1)

        var motifsByDuration = [Double : Motif]()
        var selectedMotifs = [Motif]()
        let motifDurations = split(duration: section.descriptor.phraseDuration.beats)
        for motifDuration in motifDurations {
            if let motifForDuration = motifsByDuration[motifDuration] {
                let motif: Motif
                if Bool.random() {
                    motif = motifForDuration.varied()
                } else {
                    motif = motifForDuration
                }
                selectedMotifs.append(motif)
                
            } else {
                let newMotif: Motif
                switch motifDuration {
                case 2.0:
                    newMotif = .init(duration: .twoBeats, complexity: song.genotype.complexity)
                case SectionDescriptor.MEASURE_DURATION.beats:
                    newMotif = .init(duration: .oneMeasure, complexity: song.genotype.complexity)
                case SectionDescriptor.MEASURE_DURATION.beats * 2:
                    newMotif = .init(duration: .twoMeasures, complexity: song.genotype.complexity)
                default:
                    fatalError("Unsupported motif duration found: \(motifDuration)")
                }
                selectedMotifs.append(newMotif)
                motifsByDuration[motifDuration] = newMotif
            }
        }
        
        var placementCursor = 0.0
        for motif in selectedMotifs {
            
            let chordAtCursor = Chord(from: chordDescriptorAt(location: .init(beats: placementCursor)), octave: partGenotype.octave)
            let isStaccato = Bool.random(probability: partGenotype.staccatoProbability)
            
            let motifNotedata = motif.createMIDINoteData(in: chordAtCursor, on: self.channel, with: self.velocity, using: pitches).map {noteData in
                MIDINoteData(noteNumber: noteData.noteNumber,
                               velocity: noteData.velocity,
                               channel: noteData.channel,
                               duration: isStaccato ? .init(beats: 0.25) : noteData.duration,
                               position: noteData.position + .init(beats: placementCursor))
            }
            
            midiNoteData.append(contentsOf: motifNotedata)
            placementCursor += motif.durationInBeats
        }
            
        return midiNoteData
    }

    private func chordDescriptorAt(location: Duration) -> ChordDescriptor {
        let placementIndex = section.chordPlacementMapPerPhrase.chordPlacements.firstIndex(where: {placement in
            placement.position <= location
        })!
        return section.chordProgression.chordDescriptors[placementIndex]
    }
    
    private func split(duration: Double) -> [Double] {
        var durations = [Double]()
        
        let shouldSplitFurther =
            duration > SectionDescriptor.MEASURE_DURATION.beats * 2 ||
                (duration > 2.0 && Bool.random(probability: partGenotype.motifSplitProbability))
        if shouldSplitFurther {
            durations.append(contentsOf: split(duration: duration / 2))
            durations.append(contentsOf: split(duration: duration / 2))
        } else {
            durations.append(duration)
        }
        
        return durations
    }
}
