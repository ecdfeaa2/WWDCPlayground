import SpriteKit

public class Bubble: SKShapeNode {
    
    private var _life: Int = 10
    public var life: Int {
        get {
            return _life
        } set {
            _life = newValue
            if _life == 0 {
                let actions: [SKAction] = [
                    SKAction.scale(to: 1.2, duration: 0.5),
                    SKAction.scale(to: 0.1, duration: 0.5),
                    SKAction.removeFromParent()
                ]
                self.run(SKAction.sequence(actions))
            }
        }
    }
    private var canLooseLives: Bool = false
    private var sound: String = ""
    //private var fillColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    init(position: CGPoint) {
        
        super.init()
        let radius = CGFloat(arc4random_uniform(20)) + 5
        self.path = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true).cgPath
        
        let colors = [
            #colorLiteral(red: 0.9568627451, green: 0.262745098, blue: 0.2117647059, alpha: 1),
            #colorLiteral(red: 0.6117647059, green: 0.1529411765, blue: 0.6901960784, alpha: 1),
            #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.9529411765, alpha: 1),
            #colorLiteral(red: 0, green: 0.5882352941, blue: 0.5333333333, alpha: 1),
            #colorLiteral(red: 0.8039215686, green: 0.862745098, blue: 0.2235294118, alpha: 1),
            #colorLiteral(red: 0.4745098039, green: 0.3333333333, blue: 0.2823529412, alpha: 1),
            #colorLiteral(red: 1, green: 0.2509803922, blue: 0.5058823529, alpha: 1)
        ]
        
        let arraySelector = Int(arc4random_uniform(7))
        print(arraySelector)
        let color = colors[arraySelector]
        
        let sounds = [
            "A",
            "B",
            "C",
            "D",
            "E",
            "F",
            "G"
        ]
        
        self.sound = "\(sounds[arraySelector]).m4a"
        print(sound)
        
        self.position = position
        self.fillColor = color
        
        
        physicsBody = SKPhysicsBody(circleOfRadius: radius)
        physicsBody?.isDynamic = true
        physicsBody?.mass = 1
        physicsBody?.affectedByGravity = true
        physicsBody?.friction = 0
        physicsBody?.restitution = 1
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0
        physicsBody?.allowsRotation = false
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.canLooseLives = true
        }
    }
    
    public func removeLife() {
        if canLooseLives {
            life = life - 1
            run(SKAction.playSoundFileNamed(sound, waitForCompletion: true))
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
