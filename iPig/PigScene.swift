//
//  PigScene.swift
//  MultiUseless
//
//  Created by giovane barreira on 15/08/18.
//  Copyright © 2018 Stefan V. de Moraes. All rights reserved.
//


import SpriteKit

class PigScene: SKScene {
    
    var tailBtn = SKSpriteNode()
    var bellyBtn = SKSpriteNode()
    var mouthBtn = SKSpriteNode()
    
    let angrySound = SKAction.playSoundFileNamed("pigAngry", waitForCompletion: false)
    let happySound = SKAction.playSoundFileNamed("pigHappy", waitForCompletion: false)
    let scaredSound = SKAction.playSoundFileNamed("pigScared", waitForCompletion: false)
    
    
    override func didMove(to view: SKView) {
        for node in self.children{
            if node.name == "tail"{
                if let anyNode: SKSpriteNode = node as? SKSpriteNode {
                    tailBtn = anyNode
                }
            }
            
            if node.name == "belly"{
                if let anyNode2: SKSpriteNode = node as? SKSpriteNode{
                    bellyBtn = anyNode2
                }
            }

            if node.name == "mouth"{
                if let anyNode3: SKSpriteNode = node as? SKSpriteNode{
                    mouthBtn = anyNode3
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if tailBtn.frame.contains(location){
                print("tail")
                run(angrySound)
            }
            if bellyBtn.frame.contains(location){
                print("belly")
                run(happySound)
            }

            if mouthBtn.frame.contains(location){
                print("mouth")
                run(scaredSound)
            }
        }
    }
    
}
