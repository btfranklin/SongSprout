//  Created by B.T. Franklin on 12/19/20.

import XCTest
import AudioKit
@testable import SongSprout

class MusicalScaleTests: XCTestCase {

    func testPitchCreation() {

        var scale = MusicalScale(scaleType: .major, key: .C)
        var pitchCount = (5-1) * 7
        var pitches = scale.pitches(fromOctave: 1, toOctave: 4)
        XCTAssertEqual(pitches.count, pitchCount)
        XCTAssertEqual(pitches, [
            Pitch(key: .C, octave: 1),
            Pitch(key: .D, octave: 1),
            Pitch(key: .E, octave: 1),
            Pitch(key: .F, octave: 1),
            Pitch(key: .G, octave: 1),
            Pitch(key: .A, octave: 1),
            Pitch(key: .B, octave: 1),
            Pitch(key: .C, octave: 2),
            Pitch(key: .D, octave: 2),
            Pitch(key: .E, octave: 2),
            Pitch(key: .F, octave: 2),
            Pitch(key: .G, octave: 2),
            Pitch(key: .A, octave: 2),
            Pitch(key: .B, octave: 2),
            Pitch(key: .C, octave: 3),
            Pitch(key: .D, octave: 3),
            Pitch(key: .E, octave: 3),
            Pitch(key: .F, octave: 3),
            Pitch(key: .G, octave: 3),
            Pitch(key: .A, octave: 3),
            Pitch(key: .B, octave: 3),
            Pitch(key: .C, octave: 4),
            Pitch(key: .D, octave: 4),
            Pitch(key: .E, octave: 4),
            Pitch(key: .F, octave: 4),
            Pitch(key: .G, octave: 4),
            Pitch(key: .A, octave: 4),
            Pitch(key: .B, octave: 4),
        ])


        scale = MusicalScale(scaleType: .major, key: .D)
        pitchCount = (5-1) * 7
        pitches = scale.pitches(fromOctave: 1, toOctave: 4)
        XCTAssertEqual(pitches.count, pitchCount)
        XCTAssertEqual(pitches, [
            Pitch(key: .D, octave: 1),
            Pitch(key: .E, octave: 1),
            Pitch(key: .F_sharp, octave: 1),
            Pitch(key: .G, octave: 1),
            Pitch(key: .A, octave: 1),
            Pitch(key: .B, octave: 1),
            Pitch(key: .C_sharp, octave: 2),
            Pitch(key: .D, octave: 2),
            Pitch(key: .E, octave: 2),
            Pitch(key: .F_sharp, octave: 2),
            Pitch(key: .G, octave: 2),
            Pitch(key: .A, octave: 2),
            Pitch(key: .B, octave: 2),
            Pitch(key: .C_sharp, octave: 3),
            Pitch(key: .D, octave: 3),
            Pitch(key: .E, octave: 3),
            Pitch(key: .F_sharp, octave: 3),
            Pitch(key: .G, octave: 3),
            Pitch(key: .A, octave: 3),
            Pitch(key: .B, octave: 3),
            Pitch(key: .C_sharp, octave: 4),
            Pitch(key: .D, octave: 4),
            Pitch(key: .E, octave: 4),
            Pitch(key: .F_sharp, octave: 4),
            Pitch(key: .G, octave: 4),
            Pitch(key: .A, octave: 4),
            Pitch(key: .B, octave: 4),
            Pitch(key: .C_sharp, octave: 5),
        ])

        scale = MusicalScale(scaleType: .naturalMinor, key: .D)
        pitchCount = (8-3) * 7
        pitches = scale.pitches(fromOctave: 3, toOctave: 7)
        XCTAssertEqual(pitches.count, pitchCount)
        XCTAssertEqual(pitches, [
            Pitch(key: .D, octave: 3),
            Pitch(key: .E, octave: 3),
            Pitch(key: .F, octave: 3),
            Pitch(key: .G, octave: 3),
            Pitch(key: .A, octave: 3),
            Pitch(key: .A_sharp, octave: 3),
            Pitch(key: .C, octave: 4),
            Pitch(key: .D, octave: 4),
            Pitch(key: .E, octave: 4),
            Pitch(key: .F, octave: 4),
            Pitch(key: .G, octave: 4),
            Pitch(key: .A, octave: 4),
            Pitch(key: .A_sharp, octave: 4),
            Pitch(key: .C, octave: 5),
            Pitch(key: .D, octave: 5),
            Pitch(key: .E, octave: 5),
            Pitch(key: .F, octave: 5),
            Pitch(key: .G, octave: 5),
            Pitch(key: .A, octave: 5),
            Pitch(key: .A_sharp, octave: 5),
            Pitch(key: .C, octave: 6),
            Pitch(key: .D, octave: 6),
            Pitch(key: .E, octave: 6),
            Pitch(key: .F, octave: 6),
            Pitch(key: .G, octave: 6),
            Pitch(key: .A, octave: 6),
            Pitch(key: .A_sharp, octave: 6),
            Pitch(key: .C, octave: 7),
            Pitch(key: .D, octave: 7),
            Pitch(key: .E, octave: 7),
            Pitch(key: .F, octave: 7),
            Pitch(key: .G, octave: 7),
            Pitch(key: .A, octave: 7),
            Pitch(key: .A_sharp, octave: 7),
            Pitch(key: .C, octave: 8),
        ])

        scale = MusicalScale(scaleType: .majorPentatonic, key: .F_sharp)
        pitchCount = (6-3) * 5
        pitches = scale.pitches(fromOctave: 3, toOctave: 5)
        XCTAssertEqual(pitches.count, pitchCount)
        XCTAssertEqual(pitches, [
            Pitch(key: .F_sharp, octave: 3),
            Pitch(key: .G_sharp, octave: 3),
            Pitch(key: .A_sharp, octave: 3),
            Pitch(key: .C_sharp, octave: 4),
            Pitch(key: .D_sharp, octave: 4),
            Pitch(key: .F_sharp, octave: 4),
            Pitch(key: .G_sharp, octave: 4),
            Pitch(key: .A_sharp, octave: 4),
            Pitch(key: .C_sharp, octave: 5),
            Pitch(key: .D_sharp, octave: 5),
            Pitch(key: .F_sharp, octave: 5),
            Pitch(key: .G_sharp, octave: 5),
            Pitch(key: .A_sharp, octave: 5),
            Pitch(key: .C_sharp, octave: 6),
            Pitch(key: .D_sharp, octave: 6),
        ])

        scale = MusicalScale(scaleType: .locrian, key: .E)
        pitchCount = 7
        pitches = scale.pitches(fromOctave: 5, toOctave: 5)
        XCTAssertEqual(pitches.count, pitchCount)
        XCTAssertEqual(pitches, [
            Pitch(key: .E, octave: 5),
            Pitch(key: .F, octave: 5),
            Pitch(key: .G, octave: 5),
            Pitch(key: .A, octave: 5),
            Pitch(key: .A_sharp, octave: 5),
            Pitch(key: .C, octave: 6),
            Pitch(key: .D, octave: 6),
        ])
    }
}
