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
    private var pigPosition = SKSpriteNode()
    var tailBtn = SKSpriteNode()
    var bellyBtn = SKSpriteNode()
    var mouthBtn = SKSpriteNode()
   // var backgroundNode = SKSpriteNode()
  
    
    let angrySound = SKAction.playSoundFileNamed("pigAngry", waitForCompletion: false)
    let happySound = SKAction.playSoundFileNamed("pigHappy", waitForCompletion: false)
    let scaredSound = SKAction.playSoundFileNamed("pigScared", waitForCompletion: false)
    let weeSound = SKAction.playSoundFileNamed("wee", waitForCompletion: false)
    
    //MARK: Set sprite for Pig and farm
    
    var farmItensBackground = SKSpriteNode()
    private var backgroundFarmItensAnimation: [SKTexture] = []
    
    //main node of the pig
    private var pigIdleFrame: [SKTexture] = []
    private var pigScaredFrame: [SKTexture] = []
    private var pigHappyFrame: [SKTexture] = []
    private var pigAngryFrame: [SKTexture] = []
    private var pigJumpFrame: [SKTexture] = []

    
    override func didMove(to view: SKView) {
  
        
        runBackground()
        pigIdle()
        identifyWhenTouched()

       
    }
    
    func identifyWhenTouched(){
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
                pigAngry()
                
            }
            if bellyBtn.frame.contains(location){
                run(happySound)
                pigHappy()
                
            }

            if mouthBtn.frame.contains(location){
                run(scaredSound)
                pigScared()
               
            }
        }
    }

    //funcao para rodar os sprites
    func buildAnimation(atlasName: String, nameOfSprites: String, arraySKTexture: inout [SKTexture], skSpriteNode: inout SKSpriteNode, posY: Int){
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
        skSpriteNode = SKSpriteNode(texture: firstFrameTexture)
        skSpriteNode.position = CGPoint(x: 0, y: posY)
        addChild(skSpriteNode)
    }
    
    
    func animatePig(pigTexture: [SKTexture], keyName: String, spriteNode: SKSpriteNode){
        spriteNode.run(SKAction.repeatForever(
            SKAction.animate(with: pigTexture,
                             timePerFrame: 0.05,
                             resize: false,
                             restore: true)),
                 withKey:keyName)
    }
    
    //MARK: pig animations
    
    func pigJump(){
        delaySoundEffect()
        pigPosition.removeFromParent()
        buildAnimation(atlasName: "pig_mortal", nameOfSprites: "backflip", arraySKTexture: &pigJumpFrame, skSpriteNode: &pigPosition, posY: -300)
        animatePig(pigTexture: pigJumpFrame, keyName: "pigJump", spriteNode: pigPosition)
        
    }
    
    func pigIdle(){
        buildAnimation(atlasName: "pig_inicio", nameOfSprites: "idle", arraySKTexture: &pigIdleFrame, skSpriteNode: &pigPosition, posY: -300)
        animatePig(pigTexture: pigIdleFrame, keyName: "pigIdle", spriteNode: pigPosition)
        
    }
    
    func pigScared(){
        pigPosition.removeFromParent()
        buildAnimation(atlasName: "pig_assustado", nameOfSprites: "scared", arraySKTexture: &pigHappyFrame, skSpriteNode: &pigPosition, posY: -300)
        animatePig(pigTexture: pigHappyFrame, keyName: "pigScared", spriteNode: pigPosition)
        
        backToIdlePig(waitTime: 2.5)
    }
    
    func pigHappy(){
        pigPosition.removeFromParent()
        buildAnimation(atlasName: "pig_feliz", nameOfSprites: "happy", arraySKTexture: &pigHappyFrame, skSpriteNode: &pigPosition, posY: -300)
        animatePig(pigTexture: pigHappyFrame, keyName: "pigHappy", spriteNode: pigPosition)
        
        backToIdlePig(waitTime: 1.5)
    }
    
    func pigAngry(){
        pigPosition.removeFromParent()
        buildAnimation(atlasName: "pig_bravo", nameOfSprites: "angry", arraySKTexture: &pigHappyFrame, skSpriteNode: &pigPosition, posY: -300)
        animatePig(pigTexture: pigHappyFrame, keyName: "pigAngry", spriteNode: pigPosition)
        
        backToIdlePig(waitTime: 2.5)
    }
    
    //MARK: background animation
    func runBackground(){
        
        buildAnimation(atlasName: "pig_fundoAnimado", nameOfSprites: "pig_fundo", arraySKTexture: &backgroundFarmItensAnimation, skSpriteNode: &farmItensBackground, posY: 0)
        
        animatePig(pigTexture: backgroundFarmItensAnimation, keyName: "farmItens",spriteNode: farmItensBackground)
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
    

    func addBackgroundImage(){
        let backgroundImage = SKSpriteNode(imageNamed: "fundo_pig.png")
        backgroundImage.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(backgroundImage)
    }
    


}















