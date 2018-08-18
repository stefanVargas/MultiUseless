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
    var isDrawing: Bool = false
    
    override func didMove(to view: SKView) {
        createSlices()
    }
    
    func createSlices() {
        activeSlice = SKShapeNode()
        activeSlice.strokeColor = UIColor(red: 1, green: 0.2, blue: 0, alpha: 1)
        activeSlice.lineWidth = 25
        addChild(activeSlice)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            
            let location = touch.location(in: self)
            activeSlicePoints.append(location)
            redrawActiveSlice(pointList: activeSlicePoints)
        }
        for point in activeSlicePoints{
            definitiveActiveSlicePoints.append(point)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        isDrawing = true
        let location = touch.location(in: self)
        activeSlicePoints.append(location)
        redrawActiveSlice(pointList: activeSlicePoints)
        
        for point in activeSlicePoints{
            
            definitiveActiveSlicePoints.append(point)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>?, with event: UIEvent?) {
        isDrawing = false
    }
    
    func redrawActiveSlice(pointList: [CGPoint]) {
        if isDrawing {
            let path = UIBezierPath()
            path.move(to: pointList.first!)
            for i in 1 ..< pointList.count {
                path.addLine(to: pointList[i])
            }
            activeSlice.path = path.cgPath
        }
    }

}
