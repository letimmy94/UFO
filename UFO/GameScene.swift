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
    
//create the flying object, adding
    let flyingObjectAtlas = SKTextureAtlas(named:"player")
    var flyingObjectSprites = Array<SKTexture>()
    var flyingObject = SKSpriteNode()
    var repeatActionFlyingObject = SKAction()

func createScene(){
//    edgeLoopFrom will create a physics body around the entire screen
    self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
//    defines collision interactions between our objects
    self.physicsBody?.categoryBitMask = CollisionBitMask.groundCategory
//    daniel is going to write the comments
    self.physicsBody?.collisionBitMask = CollisionBitMask.ufoCategory
    self.physicsBody?.contactTestBitMask = CollisionBitMask.ufoCategory
    self.physicsBody?.isDynamic = false
    self.physicsBody?.affectedByGravity = false
    
    self.physicsWorld.contactDelegate = self
    self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
}
}
