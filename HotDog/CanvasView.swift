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
    
    var isKetchup: Bool = true
    var isDancing: Bool = false
    
    var sauceView = SauceView.init(frame: CGRect(x: 115, y: 285, width: 88, height: 105))
    
    //var musicPath = Bundle.main.path(forResource: "dance", ofType: "mp3")!
    var danceMusic: URL! //=  URL(fileURLWithPath: Bundle.main.path(forResource: "dance.mp3", ofType: "m4a")!)

    //NSURL(fileURLWithPath: Bundle.main.path(forResource: "dance", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    
    var viewController: HotDogViewController!
    
    @IBOutlet weak var doguito: UIImageView!
    var hotDogTriste = [UIImage]()
    var hotDogDance = [UIImage]()
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.isMultipleTouchEnabled = false
        self.layer.masksToBounds = true
        
        lineClear = UIColor.clear
        lineSauce = initalSauce()
        lineWidth = 9
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.doguito.image = UIImage(named: "HDS_0")
        let touch = touches.first
        startingPoint = touch?.location(in: self)
        if sauceView.frame.contains((touch?.location(in: self))!){
            //self.doguito.image = UIImage.animatedImage(with: hotDogTriste, duration: 2.5)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.hotDogTriste = populateAnimationImages(format: "HDS_")
       
        let touch = touches.first
        touchPoint = touch?.location(in: self)
        
        path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: touchPoint)
        startingPoint = touchPoint
        drawShapeLayer(color: lineClear)
        if sauceView.frame.contains(startingPoint){
            drawShapeLayer(color: lineSauce)
            self.doguito.image = UIImage.animatedImage(with: hotDogTriste, duration: 2.5)
        }
        
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake && !isDancing{
            self.hotDogDance = populateAnimationImages(format: "HDD_")
            self.doguito.image = UIImage.animatedImage(with: hotDogDance, duration: 1.2)
            isDancing = true
            
        } else if motion == .motionShake && isDancing {
            audioPlayer.stop()
            self.doguito.image = UIImage(named: "HDS_0")
            isDancing = false
        }
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
        path.lineJoinStyle = .round
        path.lineCapStyle = .butt
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineCap = "round"
        shapeLayer.lineJoin = "round"
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
        self.setNeedsDisplay()
    }
    
    
    func clearCanvas()  {
        path.removeAllPoints()
        self.layer.sublayers = nil
        self.setNeedsDisplay()

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
    
    func populateAnimationImages(format: String) -> [UIImage] {
        
        var imagesArray = [UIImage]()
        
        for index in 0 ..< 19 {
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