//
//  PigViewController.swift
//  MultiUseless
//
//  Created by giovane barreira on 15/08/18.
//  Copyright © 2018 Stefan V. de Moraes. All rights reserved.
//

import SpriteKit
import AVFoundation

class PigViewController: UIViewController {
    
    var audioPlay = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()
        
        if let view = self.view as! SKView?{
            if let scene = SKScene(fileNamed: "PigScene"){
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            
        }
      
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            if let pigSKView = view as? SKView, let scene = pigSKView.scene as? PigScene{
                scene.pigJump()
            }
            
        }
    }
    
    func playSound(){
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "pig_backsound", ofType: "mp3")!)
        audioPlay = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        audioPlay.prepareToPlay()
        audioPlay.numberOfLoops = -1
        audioPlay.play()
        audioPlay.volume = 0.1
    }
    
    
    

}
