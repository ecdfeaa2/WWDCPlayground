import SpriteKit

public class Scene: SKScene {
    
    let ballCategory: UInt32 = 0x1 << 0
    let bottomCategory: UInt32 = 0x1 << 1
    var touchesBubbles: Int = 0
    var helpLabel: SKLabelNode? = nil
    
    override public func didMove(to view: SKView) {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        borderBody.categoryBitMask = bottomCategory
        self.physicsBody = borderBody
        physicsWorld.contactDelegate = self
        
        helpLabel = SKLabelNode(text: "Touch the screen to begin")
        helpLabel?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        helpLabel?.fontColor = .black
        self.addChild(helpLabel!)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if helpLabel?.alpha == 1 {
            helpLabel?.run(SKAction.fadeAlpha(to: 0, duration: 0.5))
        }
        guard let touch = touches.first else {
            return
        }
        if touchesBubbles >= 5 {
            return
        }
        touchesBubbles += 1
        let point = touch.location(in: self)
        let bubble = Bubble(position: point)
        bubble.physicsBody!.categoryBitMask = self.ballCategory
        bubble.physicsBody!.contactTestBitMask = self.ballCategory | self.bottomCategory
        self.addChild(bubble)
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        if touchesBubbles >= 5 {
            return
        }
        touchesBubbles += 1
        let point = touch.location(in: self)
        let bubble = Bubble(position: point)
        bubble.physicsBody!.categoryBitMask = self.ballCategory
        bubble.physicsBody!.contactTestBitMask = self.ballCategory | self.bottomCategory
        self.addChild(bubble)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesBubbles = 0
    }
}

extension Scene: SKPhysicsContactDelegate {
    public func didBegin(_ contact: SKPhysicsContact) {
        DispatchQueue.main.async {
            var firstBody: SKPhysicsBody
            var secondBody: SKPhysicsBody
            if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
                firstBody = contact.bodyA
                secondBody = contact.bodyB
            } else {
                firstBody = contact.bodyB
                secondBody = contact.bodyA
            }
            if firstBody.categoryBitMask == self.ballCategory && secondBody.categoryBitMask == self.bottomCategory {
                (firstBody.node as! Bubble).removeLife()
            } else if firstBody.categoryBitMask == self.ballCategory && secondBody.categoryBitMask == self.ballCategory {
                
                (firstBody.node as! Bubble).removeLife()
                (secondBody.node as! Bubble).removeLife()
            }
        }
    }
}
