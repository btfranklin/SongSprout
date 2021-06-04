//  Created by B.T. Franklin on 12/18/20.

import XCTest
import AudioKit
@testable import SongSprout

class DroneTrackDefinitionTests: XCTestCase {

    func testMakeNodeAndConnectRoute() {
        let partGenotype = DronePartGenotype()
        let trackDefinition = DroneTrackDefinition(for: partGenotype)
        let partNode = trackDefinition.makeNode()

        let testMixerName = "Test Mixer"
        let mixer = Mixer(name: testMixerName)
        trackDefinition.connectRoute(from: partNode, to: mixer)

        let engine = AudioEngine()
        engine.output = mixer
        do {
            try engine.start()
        } catch {
            print("AudioKit Engine failed to start: \(error)")
            return
        }

        XCTAssertEqual(mixer.connectionTreeDescription,
        """
        AudioKit | ↳Mixer("\(testMixerName)")
        AudioKit |  ↳Mixer("\(trackDefinition.identifier.rawValue) Mixer")
        AudioKit |   ↳Compressor
        AudioKit |    ↳MIDISampler("\(trackDefinition.identifier.rawValue)")
        """)
    }
}
