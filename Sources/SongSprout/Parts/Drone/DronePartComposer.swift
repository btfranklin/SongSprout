//  Created by B.T. Franklin on 2/19/20.

import AudioKit

struct DronePartComposer {
    
    private let identifier: PartIdentifier = .drone
    private let channel: PartChannel = .drone

    private let section: Section
    private let song: Song
    private let partGenotype: DronePartGenotype
    private let velocity: MIDIVelocity
    
    init(for section: Section, in song: Song, using partGenotype: DronePartGenotype) {
        self.section = section
        self.song = song
        self.partGenotype = partGenotype
        self.velocity = 100
    }
    
    func composeIntro() -> ComposedPartSection {
        compose(duration: section.duration)
    }
    
    func composeNormal() -> ComposedPartSection {
        compose(duration: section.duration)
    }
    
    func composeFinale() -> ComposedPartSection {
        compose(duration: section.descriptor.phraseDuration)
    }
    
    private func compose(duration: Duration) -> ComposedPartSection {
        var midiNoteData: [MIDINoteData] = []
        
        let octave = self.partGenotype.octave
        let pitch = Pitch(key: song.key, octave: octave)
        midiNoteData.append(.init(noteNumber: pitch.midiNoteNumber,
                                  velocity: self.velocity,
                                  channel: channel.rawValue,
                                  duration: duration,
                                  position: Duration(beats: 0)))
        
        return ComposedPartSection(partIdentifier: self.identifier, section: section, midiNoteData: midiNoteData)
    }

}
