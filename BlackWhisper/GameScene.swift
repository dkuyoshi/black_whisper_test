//
//  GameScene.swift
//  TestApp003
//
//  Created by Daiki Kuyoshi on 2021/01/11.
//  Copyright © 2021 Donkey. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var mainCaraNode = SKSpriteNode(imageNamed: "moai.png")
    let gameOverLabel = SKLabelNode()
    
    let audio = JKAudioPlayer.sharedInstance()
    let hitSound = SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: true)
    
    var hp: Int = 1000
    var countDown: Int = 499
    
    var hpLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    var countDownLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    
    // action
    let fadeinAction = SKAction.fadeIn(withDuration: 0.1)
    let fadeoutAction = SKAction.fadeOut(withDuration: 0.1)
    
    override func didMove(to view: SKView) {
        //start back music(自作)
        self.audio.playMusic("game1.mp3")
        
        // mainchara
        self.mainCaraNode.alpha = 1
        self.mainCaraNode.position = CGPoint(x: 0, y: -400)
        self.addChild(self.mainCaraNode)
        
        // Background
        self.backgroundColor = UIColor.black
        
        // Hp表示
        self.hpLabel.text = "HP: " + String(self.hp)
        self.hpLabel.fontSize = 30
        self.hpLabel.fontColor = UIColor.white
        self.hpLabel.position = CGPoint(x: -200, y: 500)
        self.addChild(self.hpLabel)
        
        //  CountDown
        self.countDownLabel.text = "Time: " + String(self.countDown)
        self.countDownLabel.fontSize = 30
        self.countDownLabel.fontColor = UIColor.white
        self.countDownLabel.position = CGPoint(x: 200, y: 500)
        self.addChild(self.countDownLabel)

        // おばけ出現
        self.addObject()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let movePos = CGPoint(x: self.mainCaraNode.position.x, y: self.mainCaraNode.position.y + 200)
        let jumpUpAction = SKAction.move(to: movePos, duration: 0.15)
        jumpUpAction.timingMode = .easeInEaseOut
        let jumpDownAction = SKAction.move(to: self.mainCaraNode.position, duration: 0.15)
        jumpDownAction.timingMode = .easeInEaseOut
        
        let jumpActions = SKAction.sequence([jumpUpAction, jumpDownAction])
        
        self.mainCaraNode.run(jumpActions)
        
        //game over check
        if self.isTouchGameOver(){
            self.audio.stopMusic()
            let nextScene = GameOverScene(fileNamed: "GameOverScene")
            nextScene?.scaleMode = .aspectFill
            self.view!.presentScene(nextScene)
        }
    }
    
    func isTouchGameOver() -> Bool{
        if self.mainCaraNode.position.y > self.view!.frame.height / 2 - 100{
            return true
        }
        return false
    }
    
    func isGameOver() -> Bool{
        if self.hp <= 0{
            return true
        }
        return false
    }
    
    func isGameClear() -> Bool{
        if self.countDown <= 0{
            return true
        }
        return false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("[debug] touchesMoved - called.")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("[debug] touchesEnded - called.")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("[debug] touchesCancelled - called.")
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.countDown -= 1
        self.countDownLabel.text = "Time: " + String(self.countDown)
        
        // GameClearCheck
        if isGameClear(){
            self.audio.stopMusic()
            let nextScene = GameClearScene(fileNamed: "GameClearScene")
            nextScene?.scaleMode = .aspectFill
            self.view!.presentScene(nextScene)
        }
        //　当たり判定
        judgeCrash()
        
        // GameOverCheck
        if isGameOver() {
            self.audio.stopMusic()
            let nextScene = GameOverScene(fileNamed: "GameOverScene")
            nextScene?.scaleMode = .aspectFill
            self.view!.presentScene(nextScene)
        }
        
    }
    
    func judgeCrash(){
        guard let node = self.childNode(withName: "ghost") else {return}
        let nodes = self.nodes(at: node.position)
        if nodes.count > 1{
            self.run(self.hitSound)
            self.hp -= 100
            self.mainCaraNode.run(SKAction.repeat(SKAction.sequence([fadeoutAction, fadeinAction]), count: 2))
            self.hpLabel.text = "HP: " + String(self.hp)
        }
    }
    
    func addObject(){
        let ghost = SKSpriteNode(imageNamed: "ghost.png")
        let yPosRandom = CGFloat(Int.random(in: 0 ..< Int(self.view!.frame.height))) - self.view!.frame.height / 2
        let yPos = self.mainCaraNode.position.y
        ghost.name  = "ghost"
        
        let fromLeft = Bool.random()
        var constLeft: Int = -1
        if !fromLeft {
            constLeft = 1
        }
        
        ghost.position = CGPoint(x: self.view!.frame.width * CGFloat(constLeft), y: yPos)
        self.addChild(ghost)
        let moveAction = SKAction.moveTo(x: self.view!.frame.width * (-CGFloat(constLeft)), duration: 0.6)
        ghost.run(
            SKAction.sequence([moveAction, SKAction.removeFromParent()])
        )
        let objectAttack = SKAction.run{
            self.addObject()
        }
        
        let randomFloatDuration = Float.random(in: 0.5..<1.5)
        let newObjectAction = SKAction.sequence([SKAction.wait(forDuration: TimeInterval(randomFloatDuration)), objectAttack])
        self.run(newObjectAction)
    }
}
