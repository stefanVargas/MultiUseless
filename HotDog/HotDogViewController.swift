//
//  HotDogViewController.swift
//  MultiUseless
//
//  Created by Stefan V. de Moraes on 15/08/2018.
//  Copyright © 2018 Stefan V. de Moraes. All rights reserved.
//

import UIKit
import AVFoundation

class HotDogViewController: UIViewController {

    @IBOutlet weak var canvas: CanvasView!
    var danceMusic: URL!
    var audioPlayer = AVAudioPlayer()
    var isPlaying: Bool = false
    let path = Bundle.main.path(forResource: "dance", ofType: "mp3", inDirectory: "HotDogAssets.xcassets")

 

    
    override func viewWillAppear(_ animated: Bool) {
        canvas.viewController = self

        danceMusic = URL(fileURLWithPath: path!)//(forResource: "dance", ofType: "mp3")!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            self.audioPlayer = try AVAudioPlayer(contentsOf: danceMusic)
            self.audioPlayer.prepareToPlay()
        } catch {
            print("ERROR")
        }
        
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if !isPlaying{
            audioPlayer.play()
            isPlaying = true
        } else {
            isPlaying = false
            audioPlayer.stop()
        }
    }

//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "HotDogScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ketchup(_ sender: Any) {
        canvas.putKetchup()
    }
    
    @IBAction func mostard(_ sender: Any) {
        canvas.putMostard()
        
    }
    
    
    @IBAction func clearCanvas(_ sender: UIButton) {
        canvas.clearCanvas()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
