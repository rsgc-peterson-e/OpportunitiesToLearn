//
//  GameScene.swift
//  StarWarsIntro
//
//  Created by Dat Boi on 2016-12-19.
//  Copyright © 2016 RSGC. All rights reserved.
//

import SpriteKit
import GameplayKit

class Scene: SKScene {
    
    var midPoint : CGPoint? // useful CGPoint object allowing me to just type midpoint instead of the x and y coordinates for the center of the screen.
    
    func showTitle() {
        backgroundColor = SKColor.black
        let title = SKSpriteNode(imageNamed: "Starwars-logo.png")
        title.setScale(0.43)
        title.position = midPoint!
        scene?.addChild(title) // display star wars title text
        let titleScaleDown = SKAction.scale(to: 0, duration: 3.5)
        title.run(titleScaleDown) // run the SKAction animation
    }
    
    func makeStars() {
        let starEmitter = SKEmitterNode()
        starEmitter.particleLifetime = 40
        starEmitter.particleBlendMode = SKBlendMode.alpha
        starEmitter.particleBirthRate = 3
        starEmitter.particleSize = CGSize(width : 3, height : 3)
        starEmitter.particleColor = SKColor(red : 100, green : 100, blue : 255, alpha : 1)
        starEmitter.position = midPoint! // make star particles spawn from center of screen behind star wars logo
        starEmitter.particleSpeed = 16
        starEmitter.particleSpeedRange = 100
        starEmitter.particlePositionRange = CGVector(dx : frame.size.width, dy : frame.size.height) // allow particles to occupy any position onscreen in their movements
        starEmitter.emissionAngle = 3.14
        starEmitter.advanceSimulationTime(40)
        starEmitter.particleAlpha = 0.5
        starEmitter.particleAlphaRange = 0.5
        scene?.addChild(starEmitter) // display the particles by adding emitter object to scene
    }
    
    func playMusic() {
        
    }
    
    override func didMove(to view: SKView) {
        midPoint = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        showTitle()
        makeStars()
    }
}