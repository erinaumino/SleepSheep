//
//  ViewController.swift
//  SleepSheep
//
//  Created by 海野恵凜那 on 2017/02/01.
//  Copyright © 2017年 erina.umino. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    @IBOutlet var label:SpringLabel!
    var number:Int = 0
    var gamescene = GameScene()

    override func viewDidLoad() {
        super.viewDidLoad()
        // SKViewに型を変換する
        let skView = self.view as! SKView
        
        // ビューと同じサイズでシーンを作成する
        gamescene = GameScene(size:skView.frame.size)
        
        // ビューにシーンを表示する
        skView.presentScene(gamescene)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func action() {
        gamescene.setupSheep()
        number = number + 1
        label.text = String(number)
        
        label.animation = "pop"
        label.animate()
            
    }
}

