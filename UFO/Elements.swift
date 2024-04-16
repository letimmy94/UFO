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
        let uFO = SKSpriteNode(texture: SKTextureAtlas(named:"player").textureNamed("donnatello"))
        uFO.size = CGSize(width: 50, height: 67)
        //        middle of frame.
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
        logoImg = SKSpriteNode(imageNamed: "donnie")
        logoImg.size = CGSize(width: 236, height: 350)
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
        taptoplayLbl.fontSize = 35
        taptoplayLbl.fontName = "HelveticaNeue"
        return taptoplayLbl
    }
    func createBlock() -> SKNode {
        block = SKNode()
        block.name = "block"
        //          at some point we should create a randomize color function here.
        let blockOne = SKSpriteNode(imageNamed: "green")
        let blockTwo = SKSpriteNode(imageNamed: "darkblue")
        let blockThree = SKSpriteNode(imageNamed: "red")
        let blockFour = SKSpriteNode(imageNamed: "yellow")
        
        blockOne.position = CGPoint(x: self.frame.width + 50, y: self.frame.height - 25)
        //          physics!!
        blockOne.physicsBody = SKPhysicsBody(rectangleOf: blockOne.size)
        blockOne.physicsBody?.categoryBitMask = CollisionBitMask.blockCategory
        blockOne.physicsBody?.collisionBitMask = CollisionBitMask.ufoCategory
        blockOne.physicsBody?.contactTestBitMask = CollisionBitMask.ufoCategory
        blockOne.physicsBody?.isDynamic = false
        blockOne.physicsBody?.affectedByGravity = false
        
        
        blockTwo.position = CGPoint(x: self.frame.width + 50, y: self.frame.height * 5 / 8 - 25 )
        blockTwo.physicsBody = SKPhysicsBody(rectangleOf: blockTwo.size)
        blockTwo.physicsBody?.categoryBitMask = CollisionBitMask.blockCategory
        blockTwo.physicsBody?.collisionBitMask = CollisionBitMask.ufoCategory
        blockTwo.physicsBody?.contactTestBitMask = CollisionBitMask.ufoCategory
        blockTwo.physicsBody?.isDynamic = false
        blockTwo.physicsBody?.affectedByGravity = false
        
        blockThree.position = CGPoint(x: self.frame.width + 50, y: self.frame.height)
        blockThree.physicsBody = SKPhysicsBody(rectangleOf: blockThree.size)
        blockThree.physicsBody?.categoryBitMask = CollisionBitMask.blockCategory
        blockThree.physicsBody?.collisionBitMask = CollisionBitMask.ufoCategory
        blockThree.physicsBody?.contactTestBitMask = CollisionBitMask.ufoCategory
        blockThree.physicsBody?.isDynamic = true
        blockThree.physicsBody?.affectedByGravity = true
       
        blockFour.position = CGPoint(x: self.frame.width + 50, y: self.frame.height / 4 - 32)
        blockFour.physicsBody = SKPhysicsBody(rectangleOf: blockFour.size)
        blockFour.physicsBody?.categoryBitMask = CollisionBitMask.blockCategory
        blockFour.physicsBody?.collisionBitMask = CollisionBitMask.ufoCategory
        blockFour.physicsBody?.contactTestBitMask = CollisionBitMask.ufoCategory
        blockFour.physicsBody?.isDynamic = false
        blockFour.physicsBody?.affectedByGravity = false
        
        block.addChild(blockOne)
        block.addChild(blockTwo)
        block.addChild(blockThree)
        block.addChild(blockFour)
        
        block.zPosition = 1
        //          spawns random blocks
        let randomBlockPosition = random(min: -200, max: 200)
        block.position.y = block.position.y +  randomBlockPosition
        //        block.position.x = block.position.x + randomBlockPosition
        
        block.run(moveAndRemove)
        
        return block
    }
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min : CGFloat, max : CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    // restart button
    func createRestartBtn() {
        restartBtn = SKSpriteNode(imageNamed: "restart")
        restartBtn.size = CGSize(width:100, height:100)
        restartBtn.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        restartBtn.zPosition = 6
        restartBtn.setScale(0)
        self.addChild(restartBtn)
        restartBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    func createScoreLabel() -> SKLabelNode {
        let scoreLbl = SKLabelNode()
        scoreLbl.position = CGPoint(x: self.frame.width / 12, y: self.frame.height / 2 + self.frame.height / 2.33)
        scoreLbl.text = "\(score)"
        scoreLbl.zPosition = 5
        scoreLbl.fontSize = 50
        scoreLbl.fontName = "HelveticaNeue-Bold"
        
        return scoreLbl
    }
    
    func createHighscoreLabel() -> SKLabelNode {
        let highscoreLbl = SKLabelNode()
        highscoreLbl.position = CGPoint(x: self.frame.width - 80, y: self.frame.height - 22)
        if let highestScore = UserDefaults.standard.object(forKey: "highestScore"){
            highscoreLbl.text = "High Score: \(highestScore)"
        } else {
            highscoreLbl.text = "High Score: 0"
        }
        highscoreLbl.zPosition = 5
        highscoreLbl.fontSize = 15
        highscoreLbl.fontName = "Helvetica-Bold"
        return highscoreLbl
    }
}
// pause button?
