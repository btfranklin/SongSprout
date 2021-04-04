//  Created by B.T. Franklin on 3/1/20.

import AudioKit
import DunesailerUtilities

struct AccompanimentPartComposer {
    
    struct AccompanimentPatternNote: Codable {
        let pitchOffset: Int
        let position: Double
        let duration: Double
    }
    
    let identifier: PartIdentifier = .accompaniment
    let channel: PartChannel = .accompaniment
    
    let section: Section
    let song: Song
    let partGenotype: AccompanimentPartGenotype
    let defaultVelocity: MIDIVelocity
    let accentedVelocity: MIDIVelocity
    
    init(for section: Section, in song: Song, using partGenotype: AccompanimentPartGenotype) {
        self.section = section
        self.song = song
        self.partGenotype = partGenotype
        self.defaultVelocity = 100
        self.accentedVelocity = 110
    }
    
    func composeNormal() -> ComposedPartSection {
        var midiNoteData: [MIDINoteData] = []
        
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
    
    // TODO review implementation
    func composeIntro() -> ComposedPartSection {
        var midiNoteData: [MIDINoteData] = []
        
        let octave = partGenotype.octave
        
        var firstChord: Chord?
        for chordIndex in 0..<section.chordProgression.chordDescriptors.count {
            
            let chordDescriptor = section.chordProgression.chordDescriptors[chordIndex]
            let chordPlacement = section.chordPlacementMapPerPhrase.chordPlacements[chordIndex]
            
            let chord: Chord
            if let firstChord = firstChord {
                chord = firstChord.findClosestInversion(using: chordDescriptor)
                
            } else {
                chord = Chord(from: chordDescriptor, octave: octave)
                firstChord = chord
            }
            
            midiNoteData.append(.init(noteNumber: chord.pitches[0].midiNoteNumber,
                                      velocity: self.defaultVelocity,
                                      channel: channel.rawValue,
                                      duration: chordPlacement.duration,
                                      position: chordPlacement.position))
        }
        
        return ComposedPartSection(partIdentifier: identifier, section: section, midiNoteData: midiNoteData)
    }
    
    func composeFinale() -> ComposedPartSection {
        var midiNoteData: [MIDINoteData] = []
        
        let octave = partGenotype.octave
        
        let chordDescriptor = section.chordProgression.chordDescriptors.first!
        let chordPlacement = section.chordPlacementMapPerPhrase.chordPlacements.first!
        
        let chord = Chord(from: chordDescriptor, octave: octave)

        let finalNoteBeats = [1.0, 2.0, SectionDescriptor.MEASURE_DURATION.beats, chordPlacement.duration.beats].randomElement()!

        for pitch in chord.pitches {
            midiNoteData.append(.init(noteNumber: pitch.midiNoteNumber,
                                      velocity: self.accentedVelocity,
                                      channel: channel.rawValue,
                                      duration: .init(beats: finalNoteBeats),
                                      position: chordPlacement.position))
        }
        
        return ComposedPartSection(partIdentifier: identifier, section: section, midiNoteData: midiNoteData)
    }
    
    private func composeNormalPhrase() -> [MIDINoteData] {
        let midiNoteData: [MIDINoteData]
        
        let phraseStyle = partGenotype.phraseStyles.randomElement()!
        switch phraseStyle {
        case .chord:
            midiNoteData = composeNormalPhraseUsingChordStyle()
        case .longChord:
            midiNoteData = composeNormalPhraseUsingLongChordStyle()
        case .decoratedChord:
            midiNoteData = composeNormalPhraseUsingDecoratedChordStyle()
        case .arpeggio:
            midiNoteData = composeNormalPhraseUsingArpeggioStyle()
        case .chordPicking:
            midiNoteData = composeNormalPhraseUsingChordPickingStyle()
        case .freeform:
            midiNoteData = composeNormalPhraseUsingFreeformStyle()
        }

        return midiNoteData
    }
    
}
