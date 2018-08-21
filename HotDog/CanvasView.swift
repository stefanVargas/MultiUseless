//
//  CanvasView.swift
//  MultiUseless
//
//  Created by Stefan V. de Moraes on 16/08/2018.
//  Copyright © 2018 Stefan V. de Moraes. All rights reserved.
//

import UIKit
import AVFoundation

class CanvasView: UIView {
    
    var lineClear: UIColor!
    var lineSauce: UIColor!
    var lineCor3: UIColor!
    var lineWidth: CGFloat!
    var path: UIBezierPath!
    var touchPoint: CGPoint!
    var startingPoint: CGPoint!
    
    let animation = UIImage()
    
    var isKetchup: Bool = true
    var isDancing: Bool = false
    
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var doguito: UIImageView!
    
    var sauceView = CGRect()

    
    var hotDogTriste = [UIImage]()
    var hotDogDance = [UIImage]()
    
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.isMultipleTouchEnabled = false
        sauceView = doguito.frame.insetBy(dx: 155, dy: 185).intersection(doguito.frame.offsetBy(dx: 155, dy: 340))
        
        lineClear = UIColor.clear
        lineSauce = initalSauce()
        lineWidth = 10
    
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        startingPoint = touch?.location(in: self)
        isDancing = false
        playMusic()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.hotDogTriste = populateAnimationImages(format: "HDS_", numDeImages: 19)
       
        let touch = touches.first
        touchPoint = touch?.location(in: self)
        
        path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: touchPoint)
        startingPoint = touchPoint
        drawShapeLayer(color: lineClear)
        if sauceView.contains(startingPoint){
            drawShapeLayer(color: lineSauce)
            self.doguito.image = UIImage.animatedImage(with: hotDogTriste, duration: 2.5)
        }
        
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake && !isDancing{
            self.hotDogDance = populateAnimationImages(format: "HDD_", numDeImages: 27)
            self.doguito.image = UIImage.animatedImage(with: hotDogDance, duration: 0.85)
            isDancing = true
            
        } else if motion == .motionShake && isDancing {
            self.doguito.image = UIImage(named: "HDS_0")
            isDancing = false
        }
        
        playMusic()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.doguito.image = UIImage(named: "HDS_0")
    }
   
//    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
//        if motion == .motionShake{
//            self.hotDogDance = populateAnimationImages(format: "HDD_")
//            self.doguito.image = UIImage.animatedImage(with: hotDogDance, duration: 1.3)
//            for _ in 0...25{
//                print("Dance")
//            }
//            self.doguito.image = UIImage(named: "HDS_0")
//        }
//    }
    
    func drawShapeLayer(color: UIColor){
        
        let shapeLayer = CAShapeLayer()

        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineCap = "round"
        //shapeLayer.lineJoin = "round"
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
        self.setNeedsDisplay()
    }
    
    
    func clearCanvas()  {
        path.addLine(to: CGPoint(x: 1, y: 1))
        path.removeAllPoints()
        self.layer.sublayers = nil
        self.setNeedsDisplay()
        playMusic()

    }
    
    func putKetchup() {
        isKetchup = true
        //lineSauce = UIColor(displayP3Red: 1, green: 0.3, blue: 0.2, alpha: 0.65)
    }
    
    func putMostard() {
        isKetchup = false
        //lineSauce = UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.2, alpha: 0.65)
    }
    
    func initalSauce() -> UIColor {
        
        if !isKetchup {
            lineSauce = UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.2, alpha: 0.65)
            return lineSauce!
        }
        
        lineSauce = UIColor(displayP3Red: 1, green: 0.3, blue: 0.2, alpha: 0.65)
        return lineSauce!

    }
    
    func playMusic() {
        
        if isDancing{
            let path = Bundle.main.path(forResource: "dance.mp3", ofType:nil)!
            let url = URL(fileURLWithPath: path)
            
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = 9
                audioPlayer?.play()
            } catch {
                // couldn't load file :(
            }
        }
        else if !isDancing {
            self.audioPlayer?.stop()
        }
        
    }
    
    func populateAnimationImages(format: String, numDeImages: Int) -> [UIImage] {
        
        var imagesArray = [UIImage]()
        
        for index in 0 ..< numDeImages {
            imagesArray.append( UIImage(named: format + "\(index)")!)
        }
        
        return imagesArray
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
