//: Bubbles: Playground made by Rémy Da Costa Faro for the WWDC.

import SpriteKit
import PlaygroundSupport

func run() {
    let frame = CGRect(x: 0, y: 0, width: 500, height: 600)
    let scene = Scene(size: CGSize(width: frame.width, height: frame.height))
    let view = SKView(frame: frame)
    view.showsPhysics = false
    view.presentScene(scene)
    PlaygroundPage.current.liveView = view
}

run()
