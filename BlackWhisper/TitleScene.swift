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
    let titleImg = SKSpriteNode(imageNamed: "tarantula.png")
    let startButton = SKSpriteNode(imageNamed: "moai.png", normalMapped: true)
    let fakeButton = SKSpriteNode(imageNamed: "devildoll_bk.png", normalMapped: true)
    //back bgm
    // var audioPlayer: AVAudioPlayer?
    // var backgroundMusic = SKAudioNode()
    // let musicPath = Bundle.main.url(forResource: "title1", withExtension: "mp3")
    let audio = JKAudioPlayer.sharedInstance()
    
    let blueCircle = SKShapeNode(circleOfRadius: 30)
    
    override func didMove(to view: SKView){
        self.backgroundColor = UIColor.black
        self.titleLabel.text = "Black Whisper of U"
        self.titleLabel.fontSize = 40
        self.titleLabel.fontColor = UIColor.red
        self.titleLabel.position = CGPoint(x: 0, y: 300)
        self.addChild(titleLabel)
        
        self.titleImg.position = CGPoint(x: 0, y: 0)
        addChild(self.titleImg)
        
        self.startLabel.text = ""
        self.startLabel.fontSize = 60
        self.startLabel.fontColor = UIColor.red
        self.startLabel.position = CGPoint(x:0, y:-300)
        self.addChild(self.startLabel)
        
        //start back music
        self.audio.playMusic("title2.mp3")
        
        // start button
        self.startButton.name = "start"
        self.startButton.position = CGPoint(x: 0, y:-400)
        self.startButton.zPosition = 120
        self.startButton.alpha = 0.9
        self.addChild(self.startButton)
        let fadeinAction = SKAction.fadeIn(withDuration: 0.5)
        let fadeoutAction = SKAction.fadeOut(withDuration: 0.5)
        let waitAction = SKAction.wait(forDuration: 1.0)
        self.startButton.run(SKAction.repeatForever(SKAction.sequence([fadeinAction,waitAction, fadeoutAction])))
        
        // fake button
        self.fakeButton.name = "fake"
        self.fakeButton.position = CGPoint(x: 90, y:140)
        self.startButton.zPosition = 120
        self.addChild(self.fakeButton)
        
        //circle button
        self.blueCircle.fillColor = .blue
        self.blueCircle.strokeColor = .blue
        self.addChild(self.blueCircle)
        let biggerCircleAction = SKAction.scale(to: 5, duration: 1.0)
        let smallCircleAction = SKAction.scale(to: 0, duration: 1.0)
        let allAction = SKAction.sequence([ biggerCircleAction, smallCircleAction])
        self.blueCircle.run((SKAction.repeatForever(allAction)))
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
}
