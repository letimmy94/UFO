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
    let music = SKAction.playSoundFileNamed("Komiku_-_54_-_Escaping_like_Indiana_Jones.mp3", waitForCompletion: false)
    
// when we do scores... add them here
//start
    var taptoplayLbl = SKLabelNode()
//restart
    var restartBtn = SKSpriteNode()
// squares need to be involved in spritekit
    var squares = SKNode()
// for game movement:
    var moveAndRemove = SKAction()
    
//create the UFO, adding
    let uFOAtlas = SKTextureAtlas(named:"player")
    var uFOSprites = Array<SKTexture>()
    var uFO = SKSpriteNode()
    var repeatActionUFO = SKAction()

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
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
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
        
        self.uFO = createUFO()
        self.addChild(uFO)
        
        let animateuFO = SKAction.animate(with: self.uFOSprites, timePerFrame: 0.1)
        self.repeatActionUFO = SKAction.repeatForever(animateuFO)
    }
    override func didMove(to view: SKView) {
        createScene()
    }
    // don't totally get this, but this tells the background how to move. Spritekit is complicated as all hell.
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
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
}
