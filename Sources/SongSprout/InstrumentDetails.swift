//  Created by B.T. Franklin on 12/26/19.

struct InstrumentDetails: Codable, Hashable {
    let name: String
    let bank: Int
    let preset: Int
    let hasContinuousSustain: Bool
    let hasFastAttack: Bool
    let recommendedLowOctave: Int
    let recommendedHighOctave: Int
}
