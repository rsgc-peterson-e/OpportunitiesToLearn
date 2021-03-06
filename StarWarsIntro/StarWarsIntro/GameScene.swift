//
//  GameScene.swift
//  StarWarsIntro
//
//  Created by Ethan Peterson on 2016-12-19.
//  Copyright © 2016 Ethan Peterson. All rights reserved.
//

import SpriteKit
import GameplayKit

class Scene: SKScene {

    var midPoint : CGPoint? // useful CGPoint object allowing me to just type midpoint instead of the x and y coordinates for the center of the screen.
    
    var introWait : TimeInterval? // Global variable that will hold the total time in seconds it takes the scrolling text intro to end
    var planet : SKSpriteNode?
    
    let textColor = SKColor(red : 252/255, green : 223/255, blue : 43/255, alpha : 1) // useful variable to prevent retyping the color data for the scrolling text.
    
    var camIsPanned : Bool = false // true if camera has panned to death Star and Alderaan
    var waitCompleted : Bool = false // true if the correct amount of time has been waited before panning the camera
    var animationFinished : Bool = false // true if the animation is completed and the camera can be panned to the end screen
    var endScreenShowing : Bool = false // true if the end screen is showing signalling it is O.K to show the "The End" text
    
    var panAmount : Double?
    
    let finalCameraPos = CGPoint(x: -228.125, y: 300.0) // stores final position of the camera after the pan
    let endScreenCameraPos = CGPoint(x: -228.125, y: 928.125) // stores position of camera at the end screen
    var end : SKLabelNode? // variable storing text to be shown on the end screen
    
    var layers = [SKShapeNode]() // holds all the different SKShapeNodes required to draw the Death Star
    
    var weaponLines = [[CGPoint]](repeating : [CGPoint](repeating : CGPoint(x: 0, y: 0), count : 2), count : 5) //array that will hold the enpoints of several lines that will be used to replicate the Death Star firing
    
    var timeBeforeExplosion : TimeInterval?
    
    // Function to Initialize the Camera:
    
    func setupCamera() {
        let cam = SKCameraNode()
        cam.position = midPoint!
        self.camera = cam
        self.addChild(cam)
    }
    
    // Main Animation Functions:
    
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
    
    
    func makeStars() { // particle emitter taken from nyan cat playground with some modifications to the properties to better suit my project.
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
    
    
    func playMusic() { // plays the star wars intro music
        let playSound = SKAction.playSoundFileNamed("intro.mp3", waitForCompletion: false) // make SKAction that plays the star wars intro music
        scene?.run(playSound) // run the SKAction playing the sound
    }
    
    
    func scrollText() { // will recreate opening crawl of star wars a new hope
        let scrollDur : TimeInterval = 30
        let titleScaleDownDur : TimeInterval = 14 // stores time interval it takes for star wars title to scale down and leave the screen
        
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

        let startingPoint = CGPoint(x: frame.size.width / 2.0, y: -20.0)
        // create closure to add the correct properties to SKLabelNodes that will be present in the paragraphs array:
        let SWLabel : (String) -> (SKLabelNode) = { text in // closure takes string to be shown on label returning an SKLabelNode object with the correct font, color, size etc.
            let label = SKLabelNode(fontNamed : "SW Crawl Body")
            label.fontColor = self.textColor
            label.fontSize = 25
            label.text = text
            label.position = startingPoint
            self.addChild(label)
            return label
        }
        
        // create paragraphs of the scrolling text intro and related variables:
        var paragraphs = [[SKLabelNode]](repeating : [SKLabelNode](repeating : SKLabelNode(text : nil), count : 7), count : 3) // build 2d paragraphs array allowing me to access the paragraph and a individual line to be displayed on screen
        
        // enter the strings for the individual lines of the first paragraph:
        paragraphs[0][0] = SWLabel("It is a period of civil war.")
        paragraphs[0][1] = SWLabel("Rebel spaceships, striking")
        paragraphs[0][2] = SWLabel("from a hidden base, have won")
        paragraphs[0][3] = SWLabel("their first victory against")
        paragraphs[0][4] = SWLabel("the evil Galactic Empire.")
        paragraphs[0].remove(at: 5) // remove empty (nil) indices not populated by lines of text
        paragraphs[0].remove(at: 5)
        
        
        // enter the strings for the second paragraph by reassigning the existing indices of the lines array:
        paragraphs[1][0] = SWLabel("During the battle,  Rebel") // NOTE: the double spacing between letters is in the same places as it was on the original New Hope title sequence
        paragraphs[1][1] = SWLabel("spies managed to steal secret")
        paragraphs[1][2] = SWLabel("plans  to  the  Empire's")
        paragraphs[1][3] = SWLabel("ultimate weapon, the DEATH")
        paragraphs[1][4] = SWLabel("STAR,  an armoured space")
        paragraphs[1][5] = SWLabel("station with enough power to")
        paragraphs[1][6] = SWLabel("destroy an entire planet.")
        
        
        // Third Paragraph:
        paragraphs[2][0] = SWLabel("Pursued  by  the  Empire's")
        paragraphs[2][1] = SWLabel("sinister  agents, Princess")
        paragraphs[2][2] = SWLabel("Leia races home aboard her")
        paragraphs[2][3] = SWLabel("starship, custodian of the")
        paragraphs[2][4] = SWLabel("stolen plans that can save")
        paragraphs[2][5] = SWLabel("her  people  and  restore")
        paragraphs[2][6] = SWLabel("freedom to the galaxy...")
        
        
        // use loops to assign the starting position and begin scrolling each line of text on timed intervals:
        let lineScroll = SKAction.moveBy(x: 0, y: frame.size.height + 24, duration: scrollDur)
        let initalWait = SKAction.wait(forDuration: titleScaleDownDur + 8)
        var lineWait = SKAction.wait(forDuration: 1.25)
        
        // scroll first paragraph
        for i in 0...paragraphs[0].count - 1 {
            lineWait = SKAction.wait(forDuration: TimeInterval(Double(i) * 1.25))
            introWait = lineWait.duration
            if (i == 0) {
                paragraphs[0][i].run(SKAction.sequence([initalWait, lineScroll]))
            } else {
                paragraphs[0][i].run(SKAction.sequence([initalWait, lineWait, lineScroll]))
            }
        }
        
        // scroll second paragraph
        let p1Wait = SKAction.wait(forDuration: TimeInterval(Double(paragraphs[0].count - 3) * 1.25))
        introWait! = introWait! + p1Wait.duration
        for j in 0...paragraphs[1].count - 1 {
            let wait = SKAction.wait(forDuration: TimeInterval(Double(j) * 1.25))
            paragraphs[1][j].run(SKAction.sequence([initalWait, p1Wait, wait, lineWait, lineScroll]))
        }
        introWait! = introWait! + TimeInterval(Double(paragraphs[1].count - 1) * 1.25)
        
        
        // scroll third paragraph
        let p2Wait = SKAction.wait(forDuration: p1Wait.duration + TimeInterval(Double(paragraphs[1].count + 1) * 1.25))
        introWait! = introWait! + p2Wait.duration
        for k in 0...paragraphs[2].count - 1 {
            let wait = SKAction.wait(forDuration: TimeInterval(Double(k) * 1.25))
            paragraphs[2][k].run(SKAction.sequence([initalWait, p2Wait, wait, lineWait, lineScroll]))
        }
        introWait! = introWait! + TimeInterval(Double(paragraphs[2].count - 1) * 1.25)
        introWait! = introWait! + initalWait.duration + (waitForTitleScaleDown.duration / 2) - 1.5
    }
    
    
    func showPlanet() { // will show Alderaan before being destroyed by the death star
        planet = SKSpriteNode(imageNamed : "planet.png") // initialize planet img
        planet!.setScale(1)
        planet!.position = CGPoint(x: finalCameraPos.x - frame.size.width / 6, y: finalCameraPos.y - frame.size.height / 8)
        self.addChild(planet!)
    }
    
    
    func showDeathStar() { // will draw Death Star using SKShapeNodes and display onscreen following the camera pan
        
        // Make closure that will return the count of layers array so that when changing the order of the layers the individual indices being accessed will not need to be changed to get the shapes to display in the correct order
        let layerCount : () -> (Int) = {
            return self.layers.count - 1
        }
        
        // draw the base circle that more shapes will be added on top of to recreate the Death Star
        let deathStarRadius : CGFloat = 75
        layers.append(SKShapeNode(circleOfRadius : deathStarRadius))
        layers[layerCount()].position = CGPoint(x: finalCameraPos.x + frame.size.width / 5.5, y: finalCameraPos.y + frame.size.height / 4)
        layers[layerCount()].strokeColor = SKColor.black
        layers[layerCount()].glowWidth = 2.0
        layers[layerCount()].fillColor = SKColor.gray
        
        // Draw Stripe of darker gray color along the middle of the Death Star
        let stripePos = CGPoint(x: layers[0].position.x - deathStarRadius + 4, y: layers[layerCount()].position.y - 10)
        let stripeWidth = (deathStarRadius * 2) - 8
        let stripeHeight : CGFloat = 20.0
        let stripe = CGRect(x: stripePos.x, y: stripePos.y, width: stripeWidth, height: stripeHeight)
        layers.append(SKShapeNode(rect : stripe))
        layers[layerCount()].fillColor = NSColor(cgColor: CGColor(gray: 75.0/255.0, alpha: 1.0))!
        layers[layerCount()].strokeColor = SKColor.black
        
        // Draw the Circle that the lasers fire from
        let weaponRadius : CGFloat = 25.0
        layers.append(SKShapeNode(circleOfRadius: weaponRadius))
        layers[layerCount()].fillColor = NSColor(cgColor: CGColor(gray: 105.0/255.0, alpha: 1.0))!
        layers[layerCount()].strokeColor = SKColor.black
        layers[layerCount()].position = CGPoint(x: stripePos.x + stripeWidth / 2, y: stripePos.y + deathStarRadius / 1.5)
        
        // Draw the dot in the middle of the circle
        layers.append(SKShapeNode(circleOfRadius: 4))
        layers[layerCount()].fillColor = SKColor.black
        layers[layerCount()].strokeColor = SKColor.black
        layers[layerCount()].position = layers[layerCount() - 1].position
        
        // Draw lines to add detail to the circle that the laser fires from
        
        // create some base points to prevent code repitition when filling the array with coordinates
        let center = layers[layerCount() - 1].position
        let right = CGPoint(x: layers[layerCount() - 1].position.x + weaponRadius, y: layers[layerCount()].position.y)
        let left = CGPoint(x: layers[layerCount() - 1].position.x - weaponRadius, y: layers[layerCount()].position.y)
        let top = CGPoint(x: center.x, y: center.y + weaponRadius)
        let bottom = CGPoint(x: center.x, y: center.y - weaponRadius)
        
        // create the array of CGPoints and the SKShapeNodes that will connect them
        var weaponLines = [[CGPoint]](repeating : [CGPoint](repeating : center, count : 2), count : 5)
        // assign points to weaponLines array
        
        // line from center to the right
        weaponLines[0] = [center, right]
        
        // line from center to the left
        weaponLines[1] = [center, left]
        
        // line from center to top
        weaponLines[2] = [center, top]
        
        // line from center to bottom
        weaponLines[3] = [center, bottom]
        
        // line from center to planet making it look like a laser firing on Alderaan
        weaponLines[4] = [center, CGPoint(x: planet!.position.x + 105, y: planet!.position.y + 50)]
        
        // use for loop to add lines to the layers array so they can be displayed onscreen
        for j in 0...weaponLines.count - 1 {
            var points : [CGPoint] = weaponLines[j]
            layers.append(SKShapeNode(points: &points, count: points.count))
            if (j == 4) {
                layers[layerCount()].fillColor = SKColor.clear
                layers[layerCount()].strokeColor = SKColor.clear
                layers[layerCount()].lineWidth = 5
            } else {
                layers[layerCount()].fillColor = SKColor.black
                layers[layerCount()].strokeColor = SKColor.black
            }
        }
        
        for i in 0...layers.count - 1 { // for loop iterating over layers array display the individual shapes
            self.addChild(layers[i])
        }
    }
    
    
    func fireDeathStar() {
        // make sure laser shows overtop of planet image
        
        planet!.zPosition = -1
        
        // Make SKAction sequence to wait for camera to pan over to the death star and fire on Alderaan after a few seconds
        let wait = SKAction.wait(forDuration: introWait! + 8.5)
        // make closure that takes an SKShapeNode and returns a new one with the correct coloring to show that the death star is preparing to fire
        let prepareToFire : (SKShapeNode) -> (SKShapeNode) = { shape in
            shape.fillColor = SKColor.green
            shape.strokeColor = SKColor.green
            return shape
        }
        let startIndex = layers.count - (weaponLines.count + 1) // starts loop at the point in the layers array the lines are at
        for i in startIndex...layers.count - 1 {
            let extraWait : TimeInterval = 1.5 * Double(i - startIndex)
            let sequence = SKAction.sequence([wait, SKAction.wait(forDuration: extraWait), SKAction.run {
                self.layers[i] = prepareToFire(self.layers[i])
                }])
            layers[i].run(sequence)
        }
        timeBeforeExplosion = introWait! + TimeInterval(6 * 1.5) + 4 + 3.5
        
        // wait and play the Death Star firing noise
        let fireSound = SKAction.playSoundFileNamed("deathStarFire.mp3", waitForCompletion: false)
        let fireSequence = SKAction.sequence([SKAction.wait(forDuration: introWait! + 8.5), fireSound])
        self.run(fireSequence)
    }
    
    
    func destroyPlanet() {
        let sequence = SKAction.sequence([SKAction.wait(forDuration: timeBeforeExplosion!), SKAction.run {
            let explosion = SKEmitterNode(fileNamed : "Explosion")
            explosion?.position = self.planet!.position
            self.addChild(explosion!) // trigger the explosion after waiting the correct amount of time
            }, SKAction.wait(forDuration: 0.5), SKAction.run {
                self.planet!.removeFromParent()
                let startIndex = self.layers.count - (self.weaponLines.count + 1)
                for i in startIndex...self.layers.count - 1 {
                    if (i - startIndex == 5) {
                        self.layers[i].fillColor = SKColor.clear
                        self.layers[i].strokeColor = SKColor.clear
                    } else {
                        self.layers[i].fillColor = SKColor.black
                        self.layers[i].strokeColor = SKColor.black
                    }
                }
            }])
        self.run(sequence)
    }
    
    
    func waitBeforePan() { // functions that will use SKActions to make sure the correct time is waited before the camera pans to Alderaan and the death star
        let sequence = SKAction.sequence([SKAction.wait(forDuration: introWait!), SKAction.run {
            self.waitCompleted = true
            }])
        
        self.run(sequence)
    }
    
    
    func finishAnimation() {
        let animationWait = SKAction.wait(forDuration: timeBeforeExplosion! + 8)
        end = SKLabelNode(fontNamed: "SW Crawl Title")
        end?.text = "The End"
        end?.fontSize = 65
        end?.fontColor = textColor
        end?.alpha = 0 // make the text invisible so it can fade in later
        end?.position = endScreenCameraPos
        self.addChild(end!) // add text to the scene so it can be displayed
        let sequence = SKAction.sequence([animationWait, SKAction.run {
            self.animationFinished = true
            }, SKAction.wait(forDuration: 5), SKAction.fadeAlpha(to: 1.0, duration: 3)])
        end?.run(sequence)
    }
    
    // Overrided SpriteKit Functions:
    
    override func didMove(to view: SKView) {
        midPoint = CGPoint(x : frame.size.width / 2.0, y : frame.size.height / 2.0)
        panAmount = Double(frame.size.width / 128)
        setupCamera()
        aLongTimeAgo()
        makeStars()
        playMusic()
        showTitle()
        scrollText()
        waitBeforePan()
        showPlanet()
        showDeathStar()
        fireDeathStar()
        destroyPlanet()
        finishAnimation()
    }
    
    
    var i : Double = 0.0 // iterator variable for camera pan to Death Star and Alderaan
    var j : Double = 0.0 // iterator variable for camera pan to upwards away from Death Star / Alderaan to end screen
    override func update(_ currentTime : TimeInterval) {
        if (camIsPanned == false && i < panAmount! && waitCompleted == true) {
            i += 0.03125 //0.03125
            self.camera?.position.x = (self.camera?.position.x)! - CGFloat(i) // slowly change the camera's x position creating a pan
        } else if (i >= panAmount!) {
            camIsPanned = true
        }
        if (animationFinished == true && j < panAmount! && endScreenShowing == false) {
            j += 0.03125
            self.camera?.position.y = (self.camera?.position.y)! + CGFloat(j) // pan camera upwards by increasing its y position
        } else if (j >= panAmount!) {
            endScreenShowing = true
        }
    }
}
