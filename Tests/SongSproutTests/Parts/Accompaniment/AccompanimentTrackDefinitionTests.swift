//  Created by B.T. Franklin on 12/16/20.

import XCTest
import AudioKit
@testable import SongSprout

class AccompanimentTrackDefinitionTests: XCTestCase {

    func testCreateNodeAndRoute() {
        let partGenotype = AccompanimentPartGenotype(complexity: .veryLow)
        let trackDefinition = AccompanimentTrackDefinition(for: partGenotype)
        let partNode = trackDefinition.createNode()

        let testMixerName = "Test Mixer"
        let mixer = Mixer(name: testMixerName)
        trackDefinition.createRoute(from: partNode, to: mixer)

        XCTAssertEqual(mixer.connectionTreeDescription,
        """
        AudioKit | ↳Mixer("\(testMixerName)")
        AudioKit |  ↳Mixer("\(trackDefinition.identifier.rawValue) Mixer")
        AudioKit |   ↳Compressor
        AudioKit |    ↳MIDISampler("\(trackDefinition.identifier.rawValue)")
        """)
    }
}
