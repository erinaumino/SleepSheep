//
//  GameScene.swift
//  SleepSheep
//
//  Created by 海野恵凜那 on 2017/02/01.
//  Copyright © 2017年 erina.umino. All rights reserved.
//

import UIKit
import SpriteKit
import AudioToolbox
import AVFoundation

class GameScene: SKScene, AVAudioPlayerDelegate{
    
    // この変数は実際のコードではUIViewControllerクラス内で宣言してる
    var audioPlayer: AVAudioPlayer?
    

    
    var scrollNode:SKNode!
    var sheep:SKSpriteNode!

    // SKView上にシーンが表示されたときに呼ばれるメソッド
    override func didMove(to view: SKView) {
        
        // スクロールするスプライトの親ノード
        scrollNode = SKNode()
        addChild(scrollNode)
        
        setupGround()
        setupCloud()
    }
    
    func setupGround() {
        // 地面の画像を読み込む
        let groundTexture = SKTexture(imageNamed: "ground")
        groundTexture.filteringMode = SKTextureFilteringMode.nearest
        
        // 必要な枚数を計算
        let needNumber = 2.0 + (frame.size.width / groundTexture.size().width)
        
        // スクロールするアクションを作成
        // 左方向に画像一枚分スクロールさせるアクション
        let moveGround = SKAction.moveBy(x: -groundTexture.size().width , y: 0, duration: 5.0)
        
        // 元の位置に戻すアクション
        let resetGround = SKAction.moveBy(x: groundTexture.size().width, y: 0, duration: 0.0)
        
        // 左にスクロール->元の位置->左にスクロールと無限に繰り替えるアクション
        let repeatScrollGround = SKAction.repeatForever(SKAction.sequence([moveGround, resetGround]))
        
        // スプライトを配置する
        stride(from: 0.0, to: needNumber, by: 1.0).forEach { i in
            let sprite = SKSpriteNode(texture: groundTexture)
            
            // スプライトの表示する位置を指定する
            sprite.position = CGPoint(x: i * sprite.size.width, y: groundTexture.size().height / 2)
            
            // スプライトにアクションを設定する
            sprite.run(repeatScrollGround)
            
            // スプライトを追加する
            scrollNode.addChild(sprite)
        }
    }
    
    func setupCloud() {
        // 雲の画像を読み込む
        let cloudTexture = SKTexture(imageNamed: "cloud")
        cloudTexture.filteringMode = SKTextureFilteringMode.nearest
        
        // 必要な枚数を計算
        let needCloudNumber = 2.0 + (frame.size.width / cloudTexture.size().width)
        
        // スクロールするアクションを作成
        // 左方向に画像一枚分スクロールさせるアクション
        let moveCloud = SKAction.moveBy(x: -cloudTexture.size().width , y: 0, duration: 20.0)
        
        // 元の位置に戻すアクション
        let resetCloud = SKAction.moveBy(x: cloudTexture.size().width, y: 0, duration: 0.0)
        
        // 左にスクロール->元の位置->左にスクロールと無限に繰り替えるアクション
        let repeatScrollCloud = SKAction.repeatForever(SKAction.sequence([moveCloud, resetCloud]))
        
        // スプライトを配置する
        stride(from: 0.0, to: needCloudNumber, by: 1.0).forEach { i in
            let sprite = SKSpriteNode(texture: cloudTexture)
            sprite.zPosition = -100 // 一番後ろになるようにする
            
            // スプライトの表示する位置を指定する
            sprite.position = CGPoint(x: i * sprite.size.width, y: size.height - cloudTexture.size().height / 2)
            
            // スプライトにアニメーションを設定する
            sprite.run(repeatScrollCloud)
            
            // スプライトを追加する
            scrollNode.addChild(sprite)
            
        }
    }
    
    func setupSheep() {
        
        
        // 羊の画像を2種類読み込む
        let sheepTexture1 = SKTexture(imageNamed: "sheep2")
        sheepTexture1.filteringMode = SKTextureFilteringMode.linear
        let sheepTexture2 = SKTexture(imageNamed: "sheep3")
        sheepTexture2.filteringMode = SKTextureFilteringMode.linear
        let sheepTexture3 = SKTexture(imageNamed: "sheep4")
        sheepTexture3.filteringMode = SKTextureFilteringMode.linear
        let sheepTexture4 = SKTexture(imageNamed: "sheep5")
        sheepTexture4.filteringMode = SKTextureFilteringMode.linear

        
        // 2種類のテクスチャを交互に変更するアニメーションを作成
        let texuresAnimation = SKAction.animate(with: [sheepTexture1, sheepTexture2, sheepTexture3, sheepTexture4], timePerFrame: 0.15)
        let flap = SKAction.repeatForever(texuresAnimation)
        
        // スプライトを作成
        sheep = SKSpriteNode(texture: sheepTexture1)
        sheep.position = CGPoint(x: 0, y: 165)
        
        // アニメーションを設定
        sheep.run(flap)
        
        // スプライトを追加する
        addChild(sheep)
        
        //移動のアニメーションを設定
        let action = SKAction.moveTo(x: 500, duration:3.0)
        sheep.run(action)
        
        //サウンドファイルを読み込む
        let url = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sheep_cry", ofType: "mp3")!)
        do{
            try audioPlayer = AVAudioPlayer(contentsOf: url as URL)
        }catch{
            print("Error!")
        }
        
        //音を再生する
        audioPlayer?.play()
    }

}
