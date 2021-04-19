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

PlaygroundPage.current.liveView = instantiateLiveView(.explanationStory)

public func startExplanation(){
    if let viewController = PlaygroundPage.current.liveView as? UIViewController{
        if let scene = IntroScene(fileNamed: "IntroScene") {
            if let view = viewController.view as? SKView{
                view.presentScene(scene)
                viewController.view = view
            }
        }
    }
}
//#-end-hidden-code
/*:
 # The 5 Positions of Ballet

 ![Feet Frame](frame_foot.png)

 The dance! A millennial art that enchants and goes even beyond, it can be a form of art and expression of oneself, it is able to develop the body and mind at the same time! Nothing better than having it practice and develop during childhood since, it has demonstrated many benefits for example: stimulates intellectual development, improves motor coordination, strengthens the muscle and enhances artistic creativity.

 Even the simplest steps demand a lot of coordination and training from a child. However, at the current time, we are facing significant challenges where such an activity that is fun and essencial like dancing has to adapt to the virtual world. Despite the fact that it can be a challenge to hold a child's attention in person, online exhibit all the more of such challenges therefore, it needs to be creative and reenvente new ways of teaching dance!

 This book has the objective of teaching in a fun and playful way the basic steps of bale, allowing the student to remain cheerful and engaged in order to continue to learn and practice. 
*/

startExplanation()


