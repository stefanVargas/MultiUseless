
import Foundation
import SpriteKit
import CoreMotion

class MonkeyScene: SKScene,  SKPhysicsContactDelegate{
    
    var motionManager = CMMotionManager()
    var destX:CGFloat  = 0.0
    var  monkeyNode: SKSpriteNode!
    
    var leftWall: SKSpriteNode!
    var rigthWall: SKSpriteNode!
    var botWall: SKSpriteNode!
    var topWall: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        addWall()
        motionManager.startAccelerometerUpdates()
        monkeyNode = childNode(withName: "Monkey") as? SKSpriteNode
        monkeyNode.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        monkeyNode.physicsBody?.affectedByGravity = true
        monkeyNode.physicsBody?.isDynamic = true
        
        monkeyNode.physicsBody?.contactTestBitMask = MonkeyCategory
        monkeyNode.physicsBody?.collisionBitMask = WallCategory
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9)
        
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
       
       
    }
    
    func addWall() {
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 0
        self.physicsBody = border
        
    }
    
    override func update(_ currentTime: TimeInterval) {
       // #if targetEnvironment(simulator)
//        if let currentTouch = lastTouchPosition {
//            let diff = CGPoint(x: currentTouch.x - monkeyNode.position.x, y: currentTouch.y - monkeyNode.position.y)
//            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
//        }
      //  #else
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
      //  #endif
    }
    
    
   
}
