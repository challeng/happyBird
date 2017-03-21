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
    var bottomPipe1 = SKSpriteNode()
    var bottomPipe2 = SKSpriteNode()
    var topPipe1 = SKSpriteNode()
    var topPipe2 = SKSpriteNode()
    var start = Bool(true)
    var birdIsActive = Bool(false)
    var pipeHeight = CGFloat(200)
    
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
        bird.size.width = bird.size.width / 6
        bird.size.height = bird.size.height / 6
        
        let animateBird = SKAction.animate(with: self.birdSprites, timePerFrame: 0.1)
        let repeatAction = SKAction.repeatForever(animateBird)
        self.bird.run(repeatAction)
        
        bottomPipe1 = SKSpriteNode(imageNamed: "bottomPipe")
        bottomPipe1.position = CGPoint(x: 0, y: -300);
        bottomPipe1.size.height = bottomPipe1.size.height
        bottomPipe1.size.width = bottomPipe1.size.width
        
        bottomPipe2 = SKSpriteNode(imageNamed: "bottomPipe")
        bottomPipe2.position = CGPoint(x: 10, y: -300);
        bottomPipe2.size.width = bottomPipe2.size.width
        bottomPipe2.size.height = bottomPipe2.size.height
        
        topPipe1 = SKSpriteNode(imageNamed: "topPipe")
        topPipe1.position = CGPoint(x: 800, y: 200)
        topPipe1.size.height = topPipe1.size.height
        topPipe1.size.width = topPipe1.size.width
        
        topPipe2 = SKSpriteNode(imageNamed: "topPipe")
        topPipe2.position = CGPoint(x: 1600, y: 200);
        topPipe2.size.height = topPipe2.size.height
        topPipe2.size.width = topPipe2.size.width
        
        
        
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        addChild(self.myBackground)
        addChild(self.myFloor1)
        addChild(self.myFloor2)
        addChild(self.bird)
        addChild(self.bottomPipe1)
        addChild(self.bottomPipe2)
        //addChild(self.topPipe1)
        //addChild(self.topPipe2)
        
        
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
        start = true

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
        myFloor1.position = CGPoint(x: myFloor1.position.x-4, y: myFloor1.position.y);
        myFloor2.position = CGPoint(x: myFloor2.position.x-4, y: myFloor2.position.y);
        
        if (myFloor1.position.x < -myFloor1.size.width / 2) {
            myFloor1.position = CGPoint(x: myFloor2.position.x + myFloor2.size.width, y: myFloor1.position.y);
        }
        
        if (myFloor2.position.x < -myFloor2.size.width / 2) {
            myFloor2.position = CGPoint(x: myFloor1.position.x + myFloor1.size.width, y: myFloor2.position.y)
        }
        
        if (start) {
            bottomPipe1.position = CGPoint(x: bottomPipe1.position.x-8, y: bottomPipe1.position.y);
            bottomPipe2.position = CGPoint(x: bottomPipe2.position.x-8, y: bottomPipe2.position.y)
            topPipe1.position = CGPoint(x: topPipe1.position.x-8, y: 180);
            topPipe2.position = CGPoint(x: topPipe2.position.x-8, y: 170);
            
            if (bottomPipe1.position.x < -bottomPipe1.size.width + 600 / 2) {
                bottomPipe1.position = CGPoint(x: bottomPipe2.position.x + bottomPipe2.size.width * 4, y: bottomPipe1.position.y);
                topPipe1.position = CGPoint(x: topPipe2.position.x + topPipe2.size.width * 4, y: pipeHeight);
            }
            
            if (bottomPipe2.position.x < -bottomPipe2.size.width + 600 / 2) {
                bottomPipe2.position = CGPoint(x: bottomPipe1.position.x + bottomPipe1.size.width * 4, y: bottomPipe2.position.y);
                topPipe2.position = CGPoint(x: topPipe1.position.x + topPipe1.size.width * 4, y: pipeHeight);
            }
            
            if (bottomPipe1.position.x < self.frame.width / 2) {
                pipeHeight = randomBetweenNumbers(firstNum: 100, secondNum: 240)
            }
        }
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum-secondNum) + min(firstNum, secondNum)
    }
}
