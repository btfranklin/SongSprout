//  Created by B.T. Franklin on 12/19/20.

import XCTest
import AudioKit
@testable import SongSprout

class VolumeTests: XCTestCase {

    func testConversion() {

        var testVolume = Volume(0)
        XCTAssertEqual(0, testVolume.mixerValue)

        testVolume = Volume(0.25)
        XCTAssertEqual(0.031622775, testVolume.mixerValue)

        testVolume = Volume(0.33)
        XCTAssertEqual(0.04570882, testVolume.mixerValue)

        testVolume = Volume(0.5)
        XCTAssertEqual(0.1, testVolume.mixerValue)

        testVolume = Volume(0.66)
        XCTAssertEqual(0.20892961, testVolume.mixerValue)

        testVolume = Volume(0.75)
        XCTAssertEqual(0.31622776, testVolume.mixerValue)

        testVolume = Volume(1.0)
        XCTAssertEqual(1.0, testVolume.mixerValue)
    }
}
