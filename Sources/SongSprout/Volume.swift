//  Created by B.T. Franklin on 2/4/20.

import Foundation
import AudioKit

public struct Volume: Equatable, Codable {
    public let mixerValue: AUValue
    public let userValue: Double
    
    public init(_ userValue: Double) {
        self.userValue = userValue
        mixerValue = AUValue(userValue == 0 ? 0 : pow(100, userValue) / 100)
    }
}
