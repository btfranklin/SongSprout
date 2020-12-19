//  Created by B.T. Franklin on 12/18/20.

import XCTest
import AudioKit
@testable import SongSprout

class DrumsTrackDefinitionTests: XCTestCase {

    func testCreateNodeAndRoute() {
        let partGenotype = DrumsPartGenotype(complexity: .veryLow)
        let trackDefinition = DrumsTrackDefinition(for: partGenotype)
        let partNode = trackDefinition.createNode()

        let testMixerName = "Test Mixer"
        let mixer = Mixer(name: testMixerName)
        trackDefinition.createRoute(from: partNode, to: mixer)

        XCTAssertTrue(mixer.connectionTreeDescription.hasPrefix(
        """
        AudioKit | ↳Mixer("\(testMixerName)")
        AudioKit |  ↳Mixer("\(trackDefinition.identifier.rawValue) Mixer")
        AudioKit |   ↳DryWetMixer
        AudioKit |    ↳MIDISampler("\(trackDefinition.identifier.rawValue)")
        """))

        // Middle is indeterminate, because different reverbs can be selected

        XCTAssertTrue(mixer.connectionTreeDescription.hasSuffix("AudioKit |     ↳MIDISampler(\"\(trackDefinition.identifier.rawValue)\")"))
    }
}
