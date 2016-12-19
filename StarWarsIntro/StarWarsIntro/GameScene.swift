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
    
    
    override func didMove(to view: SKView) {
        // Set the background color
        backgroundColor = SKColor.black
        let moveTextUp = SKAction.moveBy(x: 0, y: 30, duration: 10)
        let title = SKSpriteNode(imageNamed: "Starwars-logo.png")
        let midPoint = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        title.setScale(0.43)
        title.position = midPoint
        scene?.addChild(title)
    }
}
