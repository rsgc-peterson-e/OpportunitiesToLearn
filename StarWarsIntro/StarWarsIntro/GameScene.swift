//
//  GameScene.swift
//  StarWarsIntro
//
//  Created by Dat Boi on 2016-12-19.
//  Copyright © 2016 Ethan Peterson. All rights reserved.
//

import SpriteKit
import GameplayKit

class Scene: SKScene {
    
    var midPoint : CGPoint? // useful CGPoint object allowing me to just type midpoint instead of the x and y coordinates for the center of the screen.
    
    func aLongTimeAgo() { // will show the famous blue text A long time ago, in a galaxy...
        var opening = [SKLabelNode]()
        for _ in 1...2 {
            opening.append(SKLabelNode(fontNamed : "Franklin Gothic Book"))
        }
        // NOTE: add the proper color and font size / spacing
        opening[0].text = "A long time ago, in a galaxy"
        opening[1].text = "far, far away..."
    }
    
    func showTitle() {
        backgroundColor = SKColor.black
        let title = SKSpriteNode(imageNamed: "Starwars-logo.png")
        title.setScale(0.43)
        title.position = midPoint!
        scene?.addChild(title) // display star wars title text
        let titleScaleDown = SKAction.scale(to: 0, duration: 14)
        title.run(titleScaleDown) // run the SKAction animation
        // wait until titleScaleDown is complete to start the scrolling text
    }
    
    func makeStars() {
        let starEmitter = SKEmitterNode() // make emitter to spawn stars in the star wars animation
        starEmitter.particleLifetime = 40
        starEmitter.particleBlendMode = SKBlendMode.alpha
        starEmitter.particleBirthRate = 3
        starEmitter.particleSize = CGSize(width : 2.5, height : 2.5)
        starEmitter.particleColor = SKColor(red : 100, green : 100, blue : 255, alpha : 1)
        starEmitter.position = midPoint! // make star particles spawn from center of screen behind star wars logo
        starEmitter.particleSpeed = 16
        starEmitter.particleSpeedRange = 100
        starEmitter.particlePositionRange = CGVector(dx : frame.size.width, dy : frame.size.height) // allow particles to occupy any position onscreen in their movements
        starEmitter.emissionAngle = 3.14
        starEmitter.advanceSimulationTime(40)
        starEmitter.particleAlpha = 0.5
        starEmitter.particleAlphaRange = 0
        scene?.addChild(starEmitter) // display the particles by adding emitter object to scene
    }
    
    func playMusic() {
        let playSound = SKAction.playSoundFileNamed("intro.mp3", waitForCompletion: false) // make SKAction that plays the star wars intro music
        scene?.run(playSound) // run the SKAction playing the sound
    }
    
    func scrollText() { // will recreate opening crawl of star wars a new hope
        let scrollDur : TimeInterval = 30
        let titleScaleDownDur : TimeInterval = 14 // stores time interval it takes for star wars title to scale down and leave the screen
        let textColor = SKColor(red : 252/255, green : 223/255, blue : 43/255, alpha : 1) // useful variable to prevent retyping the color data for the scrolling text.
        
        // create SKLabel showing the episode number to be displayed following the star wars logo leaving the screen:
        
        let episodeNumWait = SKAction.wait(forDuration: titleScaleDownDur) // time in seconds the text will wait before scrolling
        let episodeNum = SKLabelNode(fontNamed : "Franklin Gothic Book")
        let episodeNumScroll = SKAction.moveBy(x: 0, y: frame.size.height + 50.0, duration: scrollDur)
        episodeNum.position = CGPoint(x: frame.size.width / 2.0, y: -30.0)
        episodeNum.text = "Episode IV"
        episodeNum.fontColor = textColor
        episodeNum.fontSize = 30
        scene?.addChild(episodeNum)
        let waitForTitleScaleDown = SKAction.sequence([episodeNumWait, episodeNumScroll]) // wait for the star wars title to zoom out and dissappear fully then scroll the text
        episodeNum.run(waitForTitleScaleDown)
        
        // create and display SKLabel for the episode title:
        
        let episodeName = SKLabelNode(fontNamed: "SW Crawl Title")
        episodeName.text = "A New Hope"
        episodeName.position = CGPoint(x: frame.size.width / 2.0, y: -50.0)
        episodeName.fontColor = textColor
        episodeName.fontSize = 65
        scene?.addChild(episodeName)
        let episodeNameScroll = SKAction.moveBy(x: 0, y: frame.size.height + 50.0, duration: scrollDur)
        let episodeNameWait = SKAction.wait(forDuration: titleScaleDownDur + 4) // extra time to wait to create spacing between the two SKlabels
        episodeName.run(SKAction.sequence([episodeNameWait, episodeNameScroll]))
        
        // create paragraphs of the scrolling text intro and related variables:
        
        
    }
    
    func showPlanet() { // will show Alderaan before being destroyed by the death star
        
    }
    
    func showDeathStar() {
        
    }
    
    func fireDeathStar() {
        
    }
    
    func destroyPlanet() {
        let explosion = SKEmitterNode(fileNamed : "Explosion")
        explosion?.position = CGPoint(x : (frame.size.width / 2.0) - 100, y : frame.size.height / 2.0)
        scene?.addChild(explosion!)
    }
    
    override func didMove(to view: SKView) {
        midPoint = CGPoint(x : frame.size.width / 2.0, y : frame.size.height / 2.0)
        aLongTimeAgo()
        makeStars()
//        playMusic()
        showTitle()
        scrollText()
    }
}
