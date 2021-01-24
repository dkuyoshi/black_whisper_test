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
import UIKit
import AVFoundation


class TitleScene: SKScene{
    
    let titleLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    let startLabel = SKLabelNode(fontNamed: "Verdana-bold")
    let titleImg = SKSpriteNode(imageNamed: "devildoll_bk.png")
    let startButton = SKSpriteNode(imageNamed: "moai.png", normalMapped: true)
    let fakeButton = SKSpriteNode(imageNamed: "tarantula.png", normalMapped: true)
    let audio = JKAudioPlayer.sharedInstance()
    let backImg = SKSpriteNode(imageNamed: "back_title.jpg", normalMapped: true)
    
    let myButton = UIButton()
    
    override func didMove(to view: SKView){
        // 背景
        self.backImg.size = self.frame.size
        self.backImg.position = CGPoint(x: 0, y: 0)
        self.backImg.zPosition = -50
        self.addChild(self.backImg)
        
        self.backgroundColor = UIColor.black
        self.titleLabel.text = "Black Whisper of U"
        self.titleLabel.fontSize = 40
        self.titleLabel.fontColor = UIColor.red
        self.titleLabel.position = CGPoint(x: 0, y: 300)
        self.addChild(titleLabel)
        
        self.titleImg.position = CGPoint(x: 0, y: 0)
        addChild(self.titleImg)
        let scaleUp = SKAction.scale(to: 10.0, duration: 0.05)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.05)
        var waitAction = SKAction.wait(forDuration: 2.5)
        self.titleImg.run(SKAction.repeatForever(SKAction.sequence([waitAction, scaleUp, scaleDown])))
        
        self.startLabel.text = ""
        self.startLabel.fontSize = 60
        self.startLabel.fontColor = UIColor.red
        self.startLabel.position = CGPoint(x:0, y:-300)
        self.addChild(self.startLabel)
        
        //start back music(自作)
        self.audio.playMusic("title1.mp3")
        
        // start button
        self.startButton.name = "start"
        self.startButton.position = CGPoint(x: 0, y:-400)
        self.startButton.zPosition = 120
        self.startButton.alpha = 0.9
        self.addChild(self.startButton)
        let fadeinAction = SKAction.fadeIn(withDuration: 0.5)
        let fadeoutAction = SKAction.fadeOut(withDuration: 0.5)
        waitAction = SKAction.wait(forDuration: 1.0)
        self.startButton.run(SKAction.repeatForever(SKAction.sequence([fadeinAction,waitAction, fadeoutAction])))
        
        // fake button
//        self.fakeButton.name = "fake"
//        self.fakeButton.position = CGPoint(x: 90, y:140)
//        self.startButton.zPosition = 120
//        self.addChild(self.fakeButton)
        
        // Start button
//        self.myButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        self.myButton.backgroundColor = .blue
//        self.myButton.layer.masksToBounds = true
//        self.myButton.setTitle("Hello", for: UIControl.State.normal)
//        self.myButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
//        self.myButton.setTitle("Hello", for: UIControl.State.highlighted)
//        self.myButton.setTitleColor(UIColor.red, for: UIControl.State.highlighted)
//        self.myButton.layer.cornerRadius = 20.0
//        self.myButton.layer.position = CGPoint(x:self.view!.frame.size.width/2, y:200)
//        self.myButton.addTarget(self, action: Selector(("onClickMyButton:")), for: .touchUpInside)
//        self.view!.addSubview(self.myButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // guard let skView = self.view else {return}
        
        for touch: AnyObject in touches{
            let touchPoint = touch.location(in: self)
            let node: SKNode! =  self.atPoint(touchPoint)
            
            if let tmpNode = node{
                if tmpNode.name == "start"{
                    gameStart()
                    return
                }
                else if tmpNode.name == "fake"{
                    gameOver()
                    return
                }
            }
        }
    }
    
    func gameStart(){
        self.audio.stopMusic()
        let nextScene = GameScene(fileNamed: "GameScene")
        nextScene?.scaleMode = self.scaleMode
        self.view!.presentScene(nextScene)
    }
    
    func gameOver(){
        self.audio.stopMusic()
        let nextScene = GameOverScene(fileNamed: "GameOverScene")
        nextScene?.scaleMode = .aspectFill
        self.view!.presentScene(nextScene)
    }
    
    func onClickMyButton(sender : UIButton){
        let rect = SKShapeNode(rectOf: CGSize(width: 50, height: 50))
        rect.fillColor = UIColor.red
        rect.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        rect.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        self.addChild(rect)
    }
}
