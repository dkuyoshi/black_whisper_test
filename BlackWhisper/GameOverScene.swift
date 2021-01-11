//
//  GameOverScene.swift
//  TestApp003
//
//  Created by Daiki Kuyoshi on 2021/01/11.
//  Copyright © 2021 Donkey. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    let endLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    let endImg = SKSpriteNode(imageNamed: "devildoll_bk.png")
    
    override func didMove(to view: SKView){
        self.backgroundColor = UIColor.red
        self.endLabel.text = "Game Over !!"
        self.endLabel.fontSize = 80
        self.endLabel.fontColor = UIColor.black
        self.endLabel.position = CGPoint(x: 0, y: 0)
        self.addChild(self.endLabel)
        
        self.endImg.position = CGPoint(x: -220, y: 400)
        addChild(self.endImg)
        
        // self.startLabel.text = "Let's Begin!!"
        // self.startLabel.fontSize = 60
        // self.startLabel.fontColor = UIColor.red
        // self.startLabel.position = CGPoint(x:0, y:-300)
        // self.addChild(self.startLabel)
    }
    
    
}
