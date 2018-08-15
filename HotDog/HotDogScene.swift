//
//  HotDogScene.swift
//  MultiUseless
//
//  Created by Stefan V. de Moraes on 15/08/2018.
//  Copyright © 2018 Stefan V. de Moraes. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class HotDogScene: SKScene {
    
    var activeSlice: SKShapeNode!
    var activeSlicePoints = [CGPoint]()
    var definitiveActiveSlicePoints = [CGPoint]()
    
    override func didMove(to view: SKView) {
        createSlices()
    }
    
    func createSlices() {
        activeSlice = SKShapeNode()
        activeSlice.strokeColor = UIColor(red: 1, green: 0.9, blue: 2, alpha: 1)
        activeSlice.lineWidth = 9
        addChild(activeSlice)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        var tempActiveSlicePoints = [CGPoint]()
        if let touch = touches.first {
            let location = touch.location(in: self)
            tempActiveSlicePoints.append(location)
            redrawActiveSlice(pointList: tempActiveSlicePoints)
        }
        for point in tempActiveSlicePoints{
            activeSlicePoints.append(point)
            definitiveActiveSlicePoints.append(point)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        var tempActiveSlicePoints = [CGPoint]()
        let location = touch.location(in: self)
        tempActiveSlicePoints.append(location)
        redrawActiveSlice(pointList: tempActiveSlicePoints)
        
        for point in tempActiveSlicePoints{
            activeSlicePoints.append(point)
            definitiveActiveSlicePoints.append(point)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>?, with event: UIEvent?) {
        
    }
    
    func redrawActiveSlice(pointList: [CGPoint]) {
        let path = UIBezierPath()
        path.move(to: pointList[0])
        for i in 1 ..< pointList.count {
            path.addLine(to: pointList[i])
        }
        activeSlice.path = path.cgPath

    }

}
