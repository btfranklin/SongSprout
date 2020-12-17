//  Created by B.T. Franklin on 12/17/19.

import AudioKit

protocol TrackDefinition {
    var identifier: PartIdentifier { get }
    
    func createNode() -> Node
    func createRoute(from signalNode: Node, to mixerNode: Mixer)
}

let GLOBAL_SOUNDFONT_NAME = "GeneralUser GS v1.471"

