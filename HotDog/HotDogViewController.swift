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
    var audioPlayer: AVAudioPlayer?
    var isPlaying: Bool = false

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
  
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        canvas.motionBegan(motion, with: event)
    }

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
