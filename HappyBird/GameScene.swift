//
//  GameScene.swift
//  HappyBird
//
//  Created by Jim Challenger on 3/21/17.
//  Copyright © 2017 Jim Challenger. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var myBackground = SKSpriteNode()
    var myFloor1 = SKSpriteNode()
    var myFloor2 = SKSpriteNode()
    let birdAtlas = SKTextureAtlas(named: "player.atlas")
    var birdSprites = Array<SKTexture>()
    var bird = SKSpriteNode()
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        myBackground = SKSpriteNode(imageNamed: "background")
        myBackground.anchorPoint = CGPoint(x: 0.5, y: 1);
        myBackground.position = CGPoint(x: 0,y: 40);
        myBackground.setScale(1.5)
        
        myFloor1 = SKSpriteNode(imageNamed: "floor")
        myFloor1.anchorPoint = CGPoint(x: 0.5, y: 3);
        myFloor1.position = CGPoint(x: 0, y: 0);
        myFloor1.setScale(1.5)
        
        myFloor2 = SKSpriteNode(imageNamed: "floor")
        myFloor2.anchorPoint = CGPoint(x: 0.5, y: 3);
        myFloor2.position = CGPoint(x: myFloor1.size.width-1, y: 0);
        myFloor2.setScale(1.5)
        
        birdSprites.append(birdAtlas.textureNamed("player1"))
        birdSprites.append(birdAtlas.textureNamed("player2"))
        birdSprites.append(birdAtlas.textureNamed("player3"))
        birdSprites.append(birdAtlas.textureNamed("player4"))
        
        bird = SKSpriteNode(texture: birdSprites[0])
        bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY);
        bird.size.width = bird.size.width / 8
        bird.size.height = bird.size.height / 8
        
        let animateBird = SKAction.animate(with: self.birdSprites, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatForever(animateBird)
        self.bird.run(repeatAction)
        
        
        
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        addChild(self.myBackground)
        addChild(self.myFloor1)
        addChild(self.myFloor2)
        addChild(self.bird)
        
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
