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
    
    override func didMove(to view: SKView) {
        print("[debug] didMove - called.")
        self.mainCaraNode.alpha = 1
        self.mainCaraNode.position = CGPoint(x: 0, y: view.frame.height / -2 + 100)
        self.addChild(self.mainCaraNode)
        
        self.backgroundColor = UIColor.black
        self.addObject()
        
        self.gameOverLabel.text = "Game Over"
        self.gameOverLabel.fontSize = 100
        self.gameOverLabel.fontName = "Verdana-bold"
        self.gameOverLabel.fontColor = UIColor.red
        self.gameOverLabel.alpha = 0
        self.addChild(gameOverLabel)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let movePos = CGPoint(x: self.mainCaraNode.position.x, y: self.mainCaraNode.position.y + 150)
        let jumpUpAction = SKAction.move(to: movePos, duration: 0.2)
        jumpUpAction.timingMode = .easeInEaseOut
        let jumpDownAction = SKAction.move(to: self.mainCaraNode.position, duration: 0.2)
        jumpDownAction.timingMode = .easeInEaseOut
        
        let jumpActions = SKAction.sequence([jumpUpAction, jumpDownAction])
        
        self.mainCaraNode.run(jumpActions)
        
        //game over check
        if self.isGameOver(){
            // self.gameOverLabel.alpha = 1
            let nextScene = GameOverScene(fileNamed: "GameOverScene")
            nextScene?.scaleMode = .aspectFill
            self.view!.presentScene(nextScene)
        }
    }
    
    func isGameOver() -> Bool{
        if self.mainCaraNode.position.y > self.view!.frame.height / 2 - 100{
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
        //　当たり判定
        guard let node = self.childNode(withName: "ghost") else {return}
        let nodes = self.nodes(at: node.position)
        if nodes.count > 1 {
            // self.gameOverLabel.alpha = 1
            let nextScene = GameOverScene(fileNamed: "GameOverScene")
            nextScene?.scaleMode = .aspectFill
            self.view!.presentScene(nextScene)
        }
    }
    
    func addObject(){
        let ghost = SKSpriteNode(imageNamed: "ghost.png")
        let yPos = CGFloat(Int.random(in: 0 ..< Int(self.view!.frame.height))) - self.view!.frame.height / 2
        ghost.name  = "ghost"
        ghost.position = CGPoint(x: self.view!.frame.width * -1, y: yPos)
        self.addChild(ghost)
        let moveAction = SKAction.moveTo(x: self.view!.frame.width, duration: 0.5)
        ghost.run(
            SKAction.sequence([moveAction, SKAction.removeFromParent()])
        )
        let objectAttack = SKAction.run{
            self.addObject()
        }
        
        let newObjectAction = SKAction.sequence([SKAction.wait(forDuration: 0.5), objectAttack])
        self.run(newObjectAction)
    }
}
