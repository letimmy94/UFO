import SpriteKit

struct CollisionBitMask {
    static let ufoCategory:UInt32 = 0x1 << 0
    static let wallCategory:UInt32 = 0x1 << 1
    static let groundCategory:UInt32 = 0x1 << 3
}

extension GameScene {
}
