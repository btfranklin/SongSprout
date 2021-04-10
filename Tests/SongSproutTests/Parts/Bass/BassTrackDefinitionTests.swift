//  Created by B.T. Franklin on 12/18/20.

import XCTest
import AudioKit
@testable import SongSprout

class BassTrackDefinitionTests: XCTestCase {

    func testMakeNodeAndConnectRoute() {
        let partGenotype = BassPartGenotype(complexity: .veryLow)
        let trackDefinition = BassTrackDefinition(for: partGenotype)
        let partNode = trackDefinition.makeNode()

        let testMixerName = "Test Mixer"
        let mixer = Mixer(name: testMixerName)
        trackDefinition.connectRoute(from: partNode, to: mixer)

        XCTAssertEqual(mixer.connectionTreeDescription,
        """
        AudioKit | ↳Mixer("\(testMixerName)")
        AudioKit |  ↳Mixer("\(trackDefinition.identifier.rawValue) Mixer")
        AudioKit |   ↳Compressor
        AudioKit |    ↳MIDISampler("\(trackDefinition.identifier.rawValue)")
        """)
    }
}
