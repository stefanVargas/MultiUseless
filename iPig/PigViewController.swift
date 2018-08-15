//
//  PigViewController.swift
//  MultiUseless
//
//  Created by giovane barreira on 15/08/18.
//  Copyright © 2018 Stefan V. de Moraes. All rights reserved.
//

import SpriteKit

class PigViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView?{
            if let scene = SKScene(fileNamed: "PigScene"){
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
            
        }

      
    }

    

}
