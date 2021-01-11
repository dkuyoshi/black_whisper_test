//
//  TitleScene.swift
//  TestApp003
//
//  Created by Daiki Kuyoshi on 2021/01/11.
//  Copyright © 2021 Donkey. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class TitleScene: SKScene{
    let titleLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    let startLabel = SKLabelNode(fontNamed: "Verdana-bold")
    let titleImg = SKSpriteNode(imageNamed: "tarantula.png")
    
    override func didMove(to view: SKView){
        self.backgroundColor = UIColor.black
        self.titleLabel.text = "Uのブラック相談室"
        self.titleLabel.fontSize = 40
        self.titleLabel.fontColor = UIColor.red
        self.titleLabel.position = CGPoint(x: 0, y: 300)
        self.addChild(titleLabel)
        
        self.titleImg.position = CGPoint(x: 0, y: 0)
        addChild(self.titleImg)
        
        self.startLabel.text = "相談を受ける"
        self.startLabel.fontSize = 60
        self.startLabel.fontColor = UIColor.red
        self.startLabel.position = CGPoint(x:0, y:-300)
        self.addChild(self.startLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // guard let skView = self.view else {return}
        
        let nextScene = GameScene(fileNamed: "GameScene")
        nextScene?.scaleMode = self.scaleMode
        self.view!.presentScene(nextScene)
    }
}
