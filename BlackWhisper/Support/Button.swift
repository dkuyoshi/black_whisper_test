//
//  Button.swift
//  BlackWhisper
//
//  Created by Daiki Kuyoshi on 2021/01/12.
//  Copyright © 2021 Donkey. All rights reserved.
//

import Foundation
import SpriteKit


class Button: SKSpriteNode{
    // 通常
    var _NormalTexture: SKTexture
    // 押したとき
    var _PushedTexture: SKTexture
    //押し込み式ボタンフラグ（一度押下すると次に押下されるまで押下時画像が表示される）
    var _IsContinuePush: Bool
    //押し込み式の場合のみ使用　現在押されているかどうかのフラグ
    var _IsPushed: Bool
    var _IsEnabled: Bool
    var delegate: CButtonDelegate?

    init(aNormalImage: String, aPushedImage: String, aKey: String){
        _NormalTexture = SKTexture(imageNamed: aNormalImage)
        _PushedTexture = SKTexture(imageNamed: aPushedImage)
        _IsContinuePush = false
        _IsPushed = false
        _IsEnabled = true
        let col = SKColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        super.init(texture:_NormalTexture, color: col, size:_NormalTexture.size())
        
        self.name = aKey
        //タッチ検出機能を有効化
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //1,delegate指定するscene 2,位置決め用spriteNode
    func SetDelegateAndPosition(aScene: SKScene, aPositionNode: SKSpriteNode){
        self.delegate = aScene as? CButtonDelegate
        //画面にボタンを追加
        aScene.addChild(self)
        //大きさの指定
        self.size = aPositionNode.size
        //位置の指定
        self.position = aPositionNode.position
        //位置決めノードは画面から消してしまう
        aPositionNode.removeFromParent()
    }
}

protocol CButtonDelegate {
    func Pushed(aButton: Button)
}
