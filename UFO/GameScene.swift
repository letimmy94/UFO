//
//  GameScene.swift
//  UFO
//
//  Created by Timmy Le and Daniel Freudberg on 4/16/18.
//  Copyright © 2018 Red Blue Green. All rights reserved.
//

import SpriteKit

class GameScene: SKScene , SKPhysicsContactDelegate {

    var isGameStarted = Bool(false)
    var isDied = Bool(false)
//    let music = SKAction.playSoundFileNamed("Komiku_-_54_-_Escaping_like_Indiana_Jones.mp3", waitForCompletion: false)
    
// when we do scores... add them here
    var score = Int(0)
    var scoreLbl = SKLabelNode()
//start
    var taptoplayLbl = SKLabelNode()
//restart
    var restartBtn = SKSpriteNode()
// squares need to be involved in spritekit
    var block = SKNode()
//    logo variable
    var logoImg = SKSpriteNode()
// for game movement:
    var moveAndRemove = SKAction()
    
//create the UFO, adding
    let uFOAtlas = SKTextureAtlas(named:"player")
    var uFOSprites = Array<SKTexture>()
    var uFO = SKSpriteNode()
    var repeatActionUFO = SKAction()
    
    override func didMove(to view: SKView) {
        createScene()
    }

    func createScene(){
//    edgeLoopFrom will create a physics body around the entire screen
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
//    defines collision interactions between our objects
        self.physicsBody?.categoryBitMask = CollisionBitMask.groundCategory
//    "Collision" literally keeps our objects from intersecting. forces them to bounce off each other. The default is everything would collide.
// https://developer.apple.com/documentation/spritekit/skphysicsbody
        self.physicsBody?.collisionBitMask = CollisionBitMask.ufoCategory
// "contact", which you think would be the same as collision is actually almost the "listener" for when objects do actually touch. Otherwise this would be known as our notifier. The default is to not be notified of contact.
        self.physicsBody?.contactTestBitMask = CollisionBitMask.ufoCategory
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        
        self.physicsWorld.contactDelegate = self
// create a repeating / scrolling background.
        for i in 0..<2
        {
            let background = SKSpriteNode(imageNamed: "ufobg")
            background.anchorPoint = CGPoint.init(x: 0, y: 0)
            background.position = CGPoint(x:CGFloat(i) * self.frame.width, y:0)
            background.name = "background"
            background.size = (self.view?.bounds.size)!
            self.addChild(background)
        }
//        setup to create ufo
        uFOSprites.append(uFOAtlas.textureNamed("obama"))
//        uFOSprites.append(uFOAtlas.textureNamed("obama1"))
//        uFOSprites.append(uFOAtlas.textureNamed("obama2"))
        
        self.uFO = createUFO()
        self.addChild(uFO)
        
//        let animateuFO = SKAction.animate(with: self.uFOSprites, timePerFrame: 1)
//        self.repeatActionUFO = SKAction.repeatForever(animateuFO)
        
        scoreLbl = createScoreLabel()
        self.addChild(scoreLbl)
        createLogo()
        
        taptoplayLbl = createTaptoplayLabel()
        self.addChild(taptoplayLbl)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isGameStarted == false{
//            sets the ufo to be affected by gravity
            isGameStarted =  true
            uFO.physicsBody?.affectedByGravity = true
//            removes logo when game begins
            logoImg.run(SKAction.scale(to: 0.1, duration: 0.3), completion: {
                self.logoImg.removeFromParent()
            })
            taptoplayLbl.removeFromParent()
//            animates the ufo
            self.uFO.run(repeatActionUFO)
//          create the block animation -- needed a lot of help from this tutorial http://sweettutos.com/2017/03/09/build-your-own-flappy-bird-game-with-swift-3-and-spritekit/ on the next ~20 lines
            let spawn = SKAction.run({
                () in
                self.block = self.createBlock()
                self.addChild(self.block)
                self.score += 1
                self.scoreLbl.text = "\(self.score)"
            })
//          spawn frequency
            let delay = SKAction.wait(forDuration: 2)
            let SpawnDelay = SKAction.sequence([spawn, delay])
            let spawnDelayForever = SKAction.repeatForever(SpawnDelay)
            self.run(spawnDelayForever)

            let distance = CGFloat(self.frame.width + block.frame.width + 20)
            let moveBlock = SKAction.moveBy(x: -distance - 50, y: 0, duration: TimeInterval(0.008 * distance))
            let removeBlock = SKAction.removeFromParent()
            moveAndRemove = SKAction.sequence([moveBlock, removeBlock])
            
            uFO.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            uFO.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
        } else {
//            ufo bounces unless it "dies"
            if isDied == false {
                uFO.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                uFO.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
            }
        }
//      restart functionality
        for touch in touches{
            let location = touch.location(in: self)
            if isDied == true { restartScene() }
            }
        }
    
//      don't totally get this, but this tells the background how to move. Spritekit is complicated as          all hell.
    override func update(_ currentTime: TimeInterval) {
//      Called before each frame is rendered
        if isGameStarted == true{
            if isDied == false{
                enumerateChildNodes(withName: "background", using: ({
                    (node, error) in
                    let bg = node as! SKSpriteNode
                    bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
                    if bg.position.x <= -bg.size.width {
                        bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y:bg.position.y)
                    }
                }))
            }
        }
    }
    
//      the headache function of all headache functions. DID BEGIN NOT DID START. Sigh.
    func didBegin(_ contact: SKPhysicsContact) {
        let firstObject = contact.bodyA
        let secondObject = contact.bodyB
        
        if firstObject.categoryBitMask == CollisionBitMask.ufoCategory && secondObject.categoryBitMask == CollisionBitMask.blockCategory || firstObject.categoryBitMask == CollisionBitMask.blockCategory && secondObject.categoryBitMask == CollisionBitMask.ufoCategory || firstObject.categoryBitMask == CollisionBitMask.ufoCategory && secondObject.categoryBitMask == CollisionBitMask.groundCategory || firstObject.categoryBitMask == CollisionBitMask.groundCategory && secondObject.categoryBitMask == CollisionBitMask.ufoCategory{
            enumerateChildNodes(withName: "block", using: ({
                (node, error) in
                node.speed = 0
                self.removeAllActions()
            }))
            if isDied == false{
                isDied = true
                createRestartBtn()
                self.uFO.removeAllActions()
            }
        }
    }
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        isDied = false
        isGameStarted = false
        score = 0
        createScene()
    }
}
