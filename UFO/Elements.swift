import SpriteKit
//sets collision points
struct CollisionBitMask {
    static let ufoCategory:UInt32 = 0x1 << 0
    static let wallCategory:UInt32 = 0x1 << 1
    static let groundCategory:UInt32 = 0x1 << 3
}

extension GameScene {
    func createUFO() -> SKSpriteNode {
//        creating sprite node for UFO
        let uFO = SKSpriteNode(texture: SKTextureAtlas(named:"player").textureNamed("obama"))
        uFO.size = CGSize(width: 50, height: 67)
        uFO.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
//        SKPhysicsBody objects allow it to behave like real world physics
        uFO.physicsBody = SKPhysicsBody(circleOfRadius: uFO.size.width / 2)
        uFO.physicsBody?.linearDamping = 1.1
        uFO.physicsBody?.restitution = 0
//        collisionBitMasks prevents objects from going through them
        uFO.physicsBody?.categoryBitMask = CollisionBitMask.ufoCategory
        uFO.physicsBody?.collisionBitMask = CollisionBitMask.wallCategory | CollisionBitMask.groundCategory
        uFO.physicsBody?.contactTestBitMask = CollisionBitMask.wallCategory | CollisionBitMask.groundCategory
//        add gravity effect upon our ufo
        uFO.physicsBody?.affectedByGravity = false
        uFO.physicsBody?.isDynamic = true
        
        return uFO
    }
    
    func createLogo() {
        logoImg = SKSpriteNode()
        logoImg = SKSpriteNode(imageNamed: "logo")
        logoImg.size = CGSize(width: 372, height: 350)
        logoImg.position = CGPoint(x:self.frame.midX, y:self.frame.midY + 100)
        logoImg.setScale(0.5)
        self.addChild(logoImg)
        logoImg.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    
    func createTaptoplayLabel() -> SKLabelNode {
        let taptoplayLbl = SKLabelNode()
        taptoplayLbl.position = CGPoint(x:self.frame.midX, y:self.frame.midY - 100)
        taptoplayLbl.text = "Tap dis"
        taptoplayLbl.fontColor = UIColor(red: 63/255, green: 79/255, blue: 145/255, alpha: 1.0)
        taptoplayLbl.zPosition = 5
        taptoplayLbl.fontSize = 20
        taptoplayLbl.fontName = "HelveticaNeue"
        return taptoplayLbl
    }
}
