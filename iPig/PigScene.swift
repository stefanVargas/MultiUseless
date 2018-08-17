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
    let weeSound = SKAction.playSoundFileNamed("wee", waitForCompletion: false)
    
    //MARK: Set sprite for Pig
    private var pigPosition = SKSpriteNode()
    private var pigIdleFrame: [SKTexture] = []
    
   // private var pigScared = SKSpriteNode()
    private var pigScaredFrame: [SKTexture] = []
    
   // private var pigHappy = SKSpriteNode()
    private var pigHappyFrame: [SKTexture] = []
    
//   private var pigAngry = SKSpriteNode()
    private var pigAngryFrame: [SKTexture] = []
    
  //  private var pigJump = SKSpriteNode()
    private var pigJumpFrame: [SKTexture] = []
    
    
    
    override func didMove(to view: SKView) {
        
        pigIdle()
    
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
                run(angrySound)
                
                pigPosition.removeFromParent()
                buildAnimation(atlasName: "pig_bravo", nameOfSprites: "angry", arraySKTexture: &pigHappyFrame)
                animatePig(pigTexture: pigHappyFrame, keyName: "pigAngry")
                
                 backToIdlePig(waitTime: 2.5)
                
            }
            if bellyBtn.frame.contains(location){
                run(happySound)
                
                pigPosition.removeFromParent()
                buildAnimation(atlasName: "pig_feliz", nameOfSprites: "happy", arraySKTexture: &pigHappyFrame)
                animatePig(pigTexture: pigHappyFrame, keyName: "pigHappy")
                
                 backToIdlePig(waitTime: 1.5)
                
            }

            if mouthBtn.frame.contains(location){
                run(scaredSound)
                
                pigPosition.removeFromParent()
                buildAnimation(atlasName: "pig_assustado", nameOfSprites: "scared", arraySKTexture: &pigHappyFrame)
                animatePig(pigTexture: pigHappyFrame, keyName: "pigScared")
                
                backToIdlePig(waitTime: 2.5)
            }
        }
    }

    //funcao para rodar os sprites
    func buildAnimation(atlasName: String, nameOfSprites: String, arraySKTexture: inout [SKTexture]){
        let walkAtlas = SKTextureAtlas(named: atlasName)
        var walkFrames: [SKTexture] = []
        let numImages = walkAtlas.textureNames.count
        
        
        for i in 0..<numImages{
            var textureName = nameOfSprites + "0\(i)"
            if i >= 10 {
                textureName = nameOfSprites + "\(i)"
            }
            
            walkFrames.append(walkAtlas.textureNamed(textureName))
        }
        
        arraySKTexture = walkFrames
        
        //Pega a primeira img do atlas e coloca numa var de textura
        let firstFrameTexture = arraySKTexture[0]
        pigPosition = SKSpriteNode(texture: firstFrameTexture)
        
        //currentNode.size = CGSize(width: 600, height: 600)
        pigPosition.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(pigPosition)
    }
    
    
    func animatePig(pigTexture: [SKTexture], keyName: String ){
        pigPosition.run(SKAction.repeatForever(
            SKAction.animate(with: pigTexture,
                             timePerFrame: 0.05,
                             resize: false,
                             restore: true)),
                 withKey:keyName)
    }
    
    func pigJump(){
        
        delaySoundEffect()
        pigPosition.removeFromParent()
        buildAnimation(atlasName: "pig_mortal", nameOfSprites: "backflip", arraySKTexture: &pigJumpFrame)
        animatePig(pigTexture: pigJumpFrame, keyName: "pigJump")
        
    }
    
    func pigIdle(){
        
        buildAnimation(atlasName: "pig_inicio", nameOfSprites: "idle", arraySKTexture: &pigIdleFrame)
        animatePig(pigTexture: pigIdleFrame, keyName: "pigIdle")
        
    }
    
    func delaySoundEffect() {
        
        let otherWait = SKAction.wait(forDuration: 1.7)
        let playSound:SKAction = SKAction.run {
            self.run(self.weeSound)
        }
        
        let waitToReset = SKAction.wait(forDuration: 1.5)
        let idle:SKAction = SKAction.run{
            self.pigPosition.removeFromParent()
            self.pigIdle()
        }
        
        
        let otherSequence = SKAction.sequence([otherWait, (playSound), waitToReset, idle])
        run(otherSequence)
    }
    
    
    func backToIdlePig(waitTime: Double){
        let waitAnimation = SKAction.wait(forDuration: waitTime)
        
        let idle:SKAction = SKAction.run{
            self.pigPosition.removeFromParent()
            self.pigIdle()
        }
        
        let otherSequence = SKAction.sequence([waitAnimation, idle])
        run(otherSequence)
        
    }
}















