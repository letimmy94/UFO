import SpriteKit
//sets collision points
struct CollisionBitMask {
    static let ufoCategory:UInt32 = 0x1 << 0
    // semanticly this needed to make more sense. wallCategory => blockCategory.
    static let blockCategory:UInt32 = 0x1 << 1
    static let groundCategory:UInt32 = 0x1 << 3
}

extension GameScene {
    func createUFO() -> SKSpriteNode {
//        creating sprite node for UFO
        let uFO = SKSpriteNode(texture: SKTextureAtlas(named:"player").textureNamed("obama"))
        uFO.size = CGSize(width: 50, height: 67)
        // middle of frame.
        uFO.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
//        SKPhysicsBody objects allow it to behave like real world physics
        uFO.physicsBody = SKPhysicsBody(circleOfRadius: uFO.size.width / 2)
        uFO.physicsBody?.linearDamping = 1.1
        uFO.physicsBody?.restitution = 0
//        collisionBitMasks prevents objects from going through them
        uFO.physicsBody?.categoryBitMask = CollisionBitMask.ufoCategory
        uFO.physicsBody?.collisionBitMask = CollisionBitMask.blockCategory | CollisionBitMask.groundCategory
        uFO.physicsBody?.contactTestBitMask = CollisionBitMask.blockCategory | CollisionBitMask.groundCategory
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
    func createBlock() -> SKNode {
        //at some point we should create a randomize function here.
        let block = SKSpriteNode(imageNamed: "darkblue")
        
        block.position = CGPoint(x: self.frame.width + 25, y: self.frame.height)
        //physics!!
        block.physicsBody = SKPhysicsBody(rectangleOf: block.size)
        block.physicsBody?.categoryBitMask = CollisionBitMask.blockCategory
        block.physicsBody?.collisionBitMask = CollisionBitMask.ufoCategory
        block.physicsBody?.contactTestBitMask = CollisionBitMask.ufoCategory
        block.physicsBody?.isDynamic = false
        block.physicsBody?.affectedByGravity = false
        
        block.zPosition = 1
        
        let randomBlockPosition = random(min: -780, max: 180)
        block.position.y = block.position.y +  randomBlockPosition
        
        block.run(moveAndRemove)
        
        return block
    }
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min : CGFloat, max : CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
}

//
// restart button
// pause button?
// score ?
