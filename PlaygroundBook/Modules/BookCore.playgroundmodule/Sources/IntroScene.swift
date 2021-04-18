//
//  GameScene.swift
//  BasicBallet
//
//  Created by Maiara Martins on 06/04/21.
//

import SpriteKit
import GameplayKit
import AVFoundation


public class IntroScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var index:Int = 0;
    private var dialogues: [Dialogue] = dialoguesHistory
    private var label : SKLabelNode?
    
    private var buttonAudio : SKSpriteNode?

    private var me : SKSpriteNode?
    private var chat : SKSpriteNode?
    private var nextButton:SKSpriteNode?
    private var returnButton:SKSpriteNode?
    private var audioMusic:SKAudioNode?

    
    private var utterance:AVSpeechUtterance!
    private let synthesizer = AVSpeechSynthesizer()
    
    public override func sceneDidLoad() {

        if let label = self.childNode(withName: "//labelNode") as? SKLabelNode {
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.preferredMaxLayoutWidth = 360
            label.run(SKAction.fadeIn(withDuration: 2.0))
            self.label = label
            self.label?.text = dialogues[index].text
        }
        
        if let me = self.childNode(withName: "//meNode") as? SKSpriteNode {
            self.me = me
        }
        
        if let chat = self.childNode(withName: "//chatNode") as? SKSpriteNode {
            self.chat = chat
            self.chat?.alpha = 1
        }
        
        if let audioMusic = self.childNode(withName: "//audioMusic") as? SKAudioNode {
            self.audioMusic = audioMusic
            self.audioMusic?.run(SKAction.changeVolume(to: Float(0.3), duration: 0))
        }
        
        
        if let buttonAudio = self.childNode(withName: "//audioButton") as? SKSpriteNode {
            self.buttonAudio = buttonAudio
            changeAudio(text: dialogues[index].text)
        }
        
        
        if let nextButton = self.childNode(withName: "//buttonNext") as? SKSpriteNode {
            self.nextButton = nextButton
            self.nextButton?.alpha = 1
        }
        
        if let returnButton = self.childNode(withName: "//buttonReturn") as? SKSpriteNode {
            self.returnButton = returnButton
            self.returnButton?.isHidden = true
            self.returnButton?.run(SKAction.init(named: "Desaper")!)
        }
        
          }
    
    public func nextPage() {
            if index + 1 < dialogues.count {
                index += 1
                if index == 1{
                    self.returnButton?.isHidden = false
                    self.returnButton?.run(SKAction.init(named: "Show")!)
                }
                self.label?.text = dialogues[index].text
                changeAudio(text: dialogues[index].text)
                self.chat?.run(SKAction.init(named: "Chat1")!)

                if let action = dialogues[index].action {
                    self.me?.run(action)
                }
            }else{
                openNewScene()
            }
        }
        
        public func returnPage() {
            if index - 1 >= 0 {
                index -= 1
                if index == 0{
                    self.returnButton?.run(SKAction.init(named: "Desaper")!)
                }
                self.label?.text = dialogues[index].text
                changeAudio(text: dialogues[index].text)
                self.chat?.run(SKAction.init(named: "Chat1")!)

                if let action = dialogues[index].action {
                    self.me?.run(action)
                }
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
                    self.buttonAudio?.run(SKAction.init(named: "AudioButton")!)
                    synthesizer.speak(utterance)
                }
            }
        }
    }
    
    
    func changeAudio(text:String){
        self.utterance = AVSpeechUtterance(string: text)
        self.utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        self.utterance.rate = 0.4
        self.utterance.pitchMultiplier = 1.5
        self.utterance.volume = 0.75
    }
    
    func openNewScene(){
        if synthesizer.isSpeaking { synthesizer.stopSpeaking(at: .immediate)}
        let transition:SKTransition = SKTransition.crossFade(withDuration: 1.5)
        if let scene = FloorScene(fileNamed: "FloorScene") {
            if let view = self.view {
                view.backgroundColor = SKColor.black
                view.presentScene(scene, transition: transition)
            }
        }
    }

}
