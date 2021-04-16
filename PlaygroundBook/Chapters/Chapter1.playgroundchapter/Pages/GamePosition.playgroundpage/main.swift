//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code
import BookCore
import SpriteKit
import PlaygroundSupport
import UIKit

PlaygroundPage.current.liveView = instantiateLiveView(.gameStory)

public func startExplanation(){
    if let viewController = PlaygroundPage.current.liveView as? UIViewController{
        if let scene = GameScene(fileNamed: "GameScene") {
            if let view = viewController.view as? SKView{
                view.presentScene(scene)
                viewController.view = view
            }
        }
    }
}

/*:
 TODO Escrever o StoryTelling com os tópicos:
 - A importância da dança no para desenvolvimento de consciência corporal, coordenação motora. ritmo, criatividade e desenvolvimento artístico
  - Dificuldade de dar aula na quarentena e prender a atenção da criança
  - Falar pouco da minha experiencia
*/

startExplanation()


