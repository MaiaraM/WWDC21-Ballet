//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code
//#-hidden-code
import BookCore
import SpriteKit
import PlaygroundSupport
import UIKit

PlaygroundPage.current.liveView = instantiateLiveView(.gameStory)

public func startGame(){
    if let viewController = PlaygroundPage.current.liveView as? UIViewController{
        if let scene = GameScene(fileNamed: "GameScene") {
            if let view = viewController.view as? SKView{
                view.presentScene(scene)
                viewController.view = view
            }
        }
    }
}
//#-end-hidden-code
/*:
 ![Play Frame](frame_play.png)
 This chapter was inspired by a game I used to do with my students when I was a dance teacher.
 
 Let's practice what you learned!! I will tell you the name of the position and you have to choose the correct one, like Simon says’

 In the top left corner I have recorded a video I did, so you can watch and help you remember.

*/

startGame()


