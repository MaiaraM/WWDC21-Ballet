//
//  FloorScene.swift
//  BasicBallet
//
//  Created by Maiara Martins on 06/04/21.
//

import SpriteKit
import GameplayKit
import AVFoundation


public class FloorScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var index:Int = 0;
    private var stepsDate: [Step]!
    private var label : SKLabelNode?
    private var chat : SKSpriteNode?
    
    private var buttonAudio : SKSpriteNode?
    private var audioNode : SKAudioNode = SKAudioNode(fileNamed: "music.mp3")
    
    private var footRight : SKSpriteNode?
    private var footLeft : SKSpriteNode?
    private var nextButton:SKSpriteNode?
    private var returnButton:SKSpriteNode?
    
    private var numberLabel : SKLabelNode!
    private var circleNumber : SKSpriteNode!
    
    var beganRight:Array<CGFloat>!
    var beganLeft:Array<CGFloat>!
    
    private var utterance:AVSpeechUtterance!
    private let synthesizer = AVSpeechSynthesizer()

    
    public override func sceneDidLoad() {
        
        if let label = self.childNode(withName: "//labelNode") as? SKLabelNode {
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.preferredMaxLayoutWidth = 400
            label.run(SKAction.fadeIn(withDuration: 2.0))
            self.label = label
        }
        
        if let chat = self.childNode(withName: "//chatNode") as? SKSpriteNode {
            self.chat = chat
        }
        
        if let circleNumber = self.childNode(withName: "//circleNumber") as? SKSpriteNode {
            self.circleNumber = circleNumber
            self.circleNumber.isHidden = true
            self.numberLabel = self.childNode(withName: "//numberLabel") as? SKLabelNode
        }
    
        if let nextButton = self.childNode(withName: "//buttonNext") as? SKSpriteNode {
            self.nextButton = nextButton
        }
        
        if let returnButton = self.childNode(withName: "//buttonReturn") as? SKSpriteNode {
            self.returnButton = returnButton
            self.returnButton?.isHidden = true
            self.returnButton?.run(SKAction.init(named: "Desaper")!)
        }
        
        if let buttonAudio = self.childNode(withName: "//audioButton") as? SKSpriteNode {
            self.buttonAudio = buttonAudio
        }
        
        
        
        if let footLeft = self.childNode(withName: "//footLeft") as? SKSpriteNode {
            beganLeft = [footLeft.position.x,footLeft.position.y ]
            self.footLeft = footLeft
        }
        
        if let footRight = self.childNode(withName: "//footRight") as? SKSpriteNode {
            beganRight = [footRight.position.x,footRight.position.y ]
            self.footRight = footRight
        }
        
        stepsDate = addSteps(beganRight: beganRight, beganLeft: beganLeft)
        self.label?.text = stepsDate[index].text
        if let textAudio = stepsDate[index].text {
            changeAudio(text: textAudio)
        }

        
    }
    
    public func nextPage() {
            if index + 1 < stepsDate.count {
                index += 1
                if index == 1{
                    self.returnButton?.isHidden = false
                    self.returnButton?.run(SKAction.init(named: "Show")!)
                }
                self.label?.text = stepsDate[index].text
                if let textAudio = stepsDate[index].text {
                    changeAudio(text: textAudio)
                }
                self.chat?.run(SKAction.init(named: "Chat")!)
                
                if let number = stepsDate[index].number {
                    self.circleNumber?.isHidden = false
                    self.circleNumber?.run(SKAction.init(named: "Show")!)
                    self.numberLabel.text = String(number)
                }else{
                    self.circleNumber?.run(SKAction.init(named: "Desaper")!)
                }

                moveFeet(stepsDate: stepsDate[index])
                
                if index + 1 == stepsDate.count {
                    self.nextButton?.run(SKAction.init(named: "Desaper")!)
                }

            }
    }
        
        public func returnPage() {
            if index - 1 >= 0 {
                index -= 1
                if index == 0{
                    self.returnButton?.run(SKAction.init(named: "Desaper")!)
                }
                self.label?.text = stepsDate[index].text
                if let textAudio = stepsDate[index].text {
                    changeAudio(text: textAudio)
                }
                self.chat?.run(SKAction.init(named: "Chat")!)
                
                if let number = stepsDate[index].number {
                    self.circleNumber?.isHidden = false
                    self.circleNumber?.run(SKAction.init(named: "Show")!)
                    self.numberLabel.text = String(number)
                }else{
                    self.circleNumber?.run(SKAction.init(named: "Desaper")!)
                }
    
                moveFeet(stepsDate: stepsDate[index])
                
            }
        }
    
    public func moveFeet(stepsDate:Step ){
        if let actionsRight = stepsDate.actionsRight {
            self.footRight?.run(actionsRight)
        }
        if let actionsLeft = stepsDate.actionsLeft {
            self.footLeft?.run(actionsLeft)
        }
    }
    

    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let point = touch.location(in: self)
            if self.atPoint(point).name == nextButton?.name{
                self.nextButton?.run(SKAction.init(named: "Click")!)
                nextPage()
            }
            if self.atPoint(point).name == returnButton?.name{
                self.returnButton?.run(SKAction.init(named: "Click")!)
                returnPage()
            }
            if self.atPoint(point).name == buttonAudio?.name{
                if !synthesizer.isSpeaking {
                    self.buttonAudio?.run(SKAction.init(named: "Click")!)
                    synthesizer.speak(utterance)
                }
            }
        }
    }
    
    func changeAudio(text:String){
        self.utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "Siri")
        utterance.rate = 0.4
        utterance.pitchMultiplier = 1.5
        utterance.volume = 0.75
    }

}
