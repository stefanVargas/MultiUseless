//
//  PigScene.swift
//  MultiUseless
//
//  Created by giovane barreira on 15/08/18.
//  Copyright © 2018 Stefan V. de Moraes. All rights reserved.
//


import SpriteKit

class PigScene: SKScene {
    
    
    //create a function
    var tailBtn = SKSpriteNode()
    var bellyBtn = SKSpriteNode()
    var mouthBtn = SKSpriteNode()
    
    let angrySound = SKAction.playSoundFileNamed("pigAngry", waitForCompletion: false)
    let happySound = SKAction.playSoundFileNamed("pigHappy", waitForCompletion: false)
    let scaredSound = SKAction.playSoundFileNamed("pigScared", waitForCompletion: false)
    
    //MARK: Set sprite for Pig
    private var dino = SKSpriteNode()
    private var dinoWalkingFrame: [SKTexture] = []
    
    private var dinoJump = SKSpriteNode()
    private var dinoJumpFrame: [SKTexture] = []
    
    private var dinoDie = SKSpriteNode()
    private var dinoDieFrame: [SKSpriteNode] = []
    
    
    override func didMove(to view: SKView) {
        
        buildAnimation(atlasName: "pig_inicio", nameOfSprites: "pig_inicio", arraySKTexture: &dinoWalkingFrame, currentNode: &dino)
        animateDino()
        
        
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
//
//    func buildDino(atlasName: String, textureName: String){
//        let dinoAnimatedAtlas = SKTextureAtlas(named: atlasName)
//        var walkFrames:[SKTexture] = []
//
//        let numImages = dinoAnimatedAtlas.textureNames.count
//        for i in 1...numImages{
//            let dinoTextureName = textureName + "\(i)"
//            walkFrames.append(dinoAnimatedAtlas.textureNamed(dinoTextureName))
//        }
//        dinoWalkingFrame = walkFrames
//
//        let firstFrameTexture = dinoWalkingFrame[0]
//        dino = SKSpriteNode(texture: firstFrameTexture)
//        dino.position = CGPoint(x: frame.midX, y: frame.midY)
//        addChild(dino)
//    }
    
    //funcao para rodar os sprites
    func buildAnimation(atlasName: String, nameOfSprites: String, arraySKTexture: inout [SKTexture], currentNode: inout SKSpriteNode){
        let walkAtlas = SKTextureAtlas(named: atlasName)
        var walkFrames: [SKTexture] = []
        let numImages = walkAtlas.textureNames.count
        
        
        for i in 0..<numImages{
            var textureName = nameOfSprites + "0\(i)"
            if i >= 10 {
                textureName = nameOfSprites + "\(i)"
            }
            
            print(walkAtlas.textureNamed(textureName))
            walkFrames.append(walkAtlas.textureNamed(textureName))
        }
        
        arraySKTexture = walkFrames
        
        //Pega a primeira img do atlas e coloca numa var de textura
        let firstFrameTexture = arraySKTexture[0]
        currentNode = SKSpriteNode(texture: firstFrameTexture)
        
        currentNode.size = CGSize(width: 600, height: 600)
        currentNode.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(currentNode)
    }
    
    
    func animateDino(){
        dino.run(SKAction.repeatForever(
            SKAction.animate(with: dinoWalkingFrame,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                 withKey:"dinoStop")
    }
    
}












