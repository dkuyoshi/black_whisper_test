//
//  GameClearScene.swift
//  BlackWhisper
//
//  Created by Daiki Kuyoshi on 2021/01/24.
//  Copyright © 2021 Donkey. All rights reserved.
//

import SpriteKit

class GameClearScene: SKScene {
    let endLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    let endImg = SKSpriteNode(imageNamed: "devildoll_bk.png")
    
    override func didMove(to view: SKView){
        self.backgroundColor = UIColor.cyan
        self.endLabel.text = "Congratulations!!"
        self.endLabel.fontSize = 65
        self.endLabel.fontColor = UIColor.white
        self.endLabel.position = CGPoint(x: 0, y: 0)
        self.addChild(self.endLabel)
        
        self.endImg.position = CGPoint(x: 220, y: 400)
        let downAction = SKAction.moveTo(y: self.endImg.position.y - 3, duration: 0.1)
        let upAction = SKAction.moveTo(y: self.endImg.position.y + 3, duration: 0.1)
        self.addChild(self.endImg)
        let allAction = SKAction.sequence([downAction, upAction])
        self.endImg.run((SKAction.repeatForever(allAction)))
        // self.startLabel.text = "Let's Begin!!"
        // self.startLabel.fontSize = 60
        // self.startLabel.fontColor = UIColor.red
        // self.startLabel.position = CGPoint(x:0, y:-300)
        // self.addChild(self.startLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let nextScene = TitleScene(fileNamed: "TitleScene")
        nextScene?.scaleMode = .aspectFill
        self.view!.presentScene(nextScene)
    }
    
}
