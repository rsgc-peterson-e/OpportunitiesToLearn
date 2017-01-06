import SpriteKit
import PlaygroundSupport

let frame = CGRect(x : 0, y : 0, width : 800, height : 600)
var scene = SKScene(size : frame.size)

let view = SKView(frame: frame)

// text animations

let moveTextUp = SKAction.moveBy(x: 0, y: 30, duration: 10)
let title = SKSpriteNode(imageNamed: "Starwars-logo.png")
let midPoint = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
title.setScale(1)
title.position = midPoint
scene.addChild(title)
view.presentScene(scene)
PlaygroundPage.current.liveView = view

