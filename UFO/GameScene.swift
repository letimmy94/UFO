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
    var flyingObjectSprites = Array()
    var flyingObject = SKSpriteNode()
    var repeatActionFlyingObject = SKAction()
}

