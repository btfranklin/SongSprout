//  Created by B.T. Franklin on 12/17/19.

import AudioKit

protocol TrackNodeProducer {

    var identifier: PartIdentifier { get }

    func makeNode() -> Node
}
