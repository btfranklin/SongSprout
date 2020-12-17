//  Created by B.T. Franklin on 12/23/19.

import AudioKit

struct ComposedPartSection {
    
    let partIdentifier: PartIdentifier
    let sectionDesignation: SectionDescriptor.Designation
    
    let midiNoteData: [MIDINoteData]
    
    init(partIdentifier: PartIdentifier, section: Section, midiNoteData: [MIDINoteData]) {
        self.partIdentifier = partIdentifier
        self.sectionDesignation = section.descriptor.designation
        self.midiNoteData = midiNoteData
    }
    
    func populate(track: SequencerTrack, from offset: Duration) {
        var noteEventSequence = track.sequence // TODO This may not work, since we may need to append
        
        for midiNoteDatum in midiNoteData {
            noteEventSequence.add(noteNumber: midiNoteDatum.noteNumber,
                                  velocity: midiNoteDatum.velocity,
                                  channel: midiNoteDatum.channel,
                                  position: midiNoteDatum.position.beats + offset.beats,
                                  duration: midiNoteDatum.duration.beats)
        }
        
        track.sequence = noteEventSequence
    }
}
