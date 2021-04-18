//
//  GameScene.swift
//  BasicBallet
//
//  Created by Maiara Martins on 08/04/21.
//
import Foundation
import SpriteKit
import GameplayKit
import AVFoundation


public class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
        
    private var buttonAudio : SKSpriteNode?
    
    private var label : SKLabelNode?
    private var chat : SKSpriteNode?
    private var videoThumb : SKSpriteNode?

    
    private var nextButton:SKSpriteNode?
    
    private var button1:SKSpriteNode?
    private var button2:SKSpriteNode?
    private var button3:SKSpriteNode?
    private var button4:SKSpriteNode?
    private var button5:SKSpriteNode?
    
    
    private var choice:String!
    private var videoIsPause:Bool = true
    private var audioMusic:SKAudioNode?

    
    private var bgVideoPlayer:AVPlayer!
    private var videoNode:SKVideoNode!
    private var barraControllerVideo =  SKSpriteNode(color: SKColor.white, size: CGSize(width: 20, height: 20))
    
    private var closeIcon = SKSpriteNode(imageNamed: "CloseIcon.png")
    private var controllerIcon = SKSpriteNode(imageNamed: "PauseIcon.png")
    private var resetIcon = SKSpriteNode(imageNamed: "ResetIcon.png")


    private var utterance:AVSpeechUtterance!
    private let synthesizer = AVSpeechSynthesizer()

    public override func didMove(to view: SKView) {
        self.videoNode?.pause()
    }
    
    public override func sceneDidLoad() {
                      
        
        if let label = self.childNode(withName: "//labelNode") as? SKLabelNode {
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.preferredMaxLayoutWidth = 350
            label.run(SKAction.fadeIn(withDuration: 2.0))
            self.label = label
        }
        
        
        if let chat = self.childNode(withName: "//chatNode") as? SKSpriteNode {
            self.chat = chat
        }
        
        if let audioMusic = self.childNode(withName: "//audioMusic") as? SKAudioNode {
            self.audioMusic = audioMusic
            self.audioMusic?.run(SKAction.changeVolume(to: Float(0.4), duration: 0))
        }
        
        
        if let nextButton = self.childNode(withName: "//buttonNext") as? SKSpriteNode {
            self.nextButton = nextButton
        }
        
        if let buttonAudio = self.childNode(withName: "//audioButton") as? SKSpriteNode {
            self.buttonAudio = buttonAudio
        }

        
        
        /// Buttons
        
        if let button1 = self.childNode(withName: "//button1") as? SKSpriteNode {
            print(button1)
            self.button1 = button1
            self.button1?.run(SKAction.init(named: "Alpha1")!)
        }
        if let button2 = self.childNode(withName: "//button2") as? SKSpriteNode {
            self.button2 = button2
            self.button2?.run(SKAction.init(named: "Alpha1")!)

        }
        if let button3 = self.childNode(withName: "//button3") as? SKSpriteNode {
            self.button3 = button3
            self.button3?.run(SKAction.init(named: "Alpha1")!)
        }
        if let button4 = self.childNode(withName: "//button4") as? SKSpriteNode {
            self.button4 = button4
            self.button4?.run(SKAction.init(named: "Alpha1")!)

        }
        if let button5 = self.childNode(withName: "//button5") as? SKSpriteNode {
            self.button5 = button5
            self.button5?.run(SKAction.init(named: "Alpha1")!)

        }
        
        if let videoThumb = self.childNode(withName: "//videoThumb") as? SKSpriteNode {
            self.videoThumb = videoThumb
            self.videoThumb?.name = "videoThumb"
            let filePath = Bundle.main.path(forResource: "Ballet", ofType: "mp4")!
            let url = URL(fileURLWithPath: filePath)
            self.bgVideoPlayer = AVPlayer(url: url)
            self.bgVideoPlayer.actionAtItemEnd = .none
            NotificationCenter.default.addObserver(self,
                selector: #selector(GameScene.bgVideoDidEnd(notification:)),
                        name: .AVPlayerItemDidPlayToEndTime,
                        object: self.bgVideoPlayer.currentItem)
            self.videoNode = SKVideoNode(avPlayer: self.bgVideoPlayer)
            self.videoNode?.size = self.size
            self.videoNode?.alpha = 0
            self.videoNode?.size = videoThumb.size
            self.videoNode?.name = "closedVideo"
            self.videoNode?.position = videoThumb.position
            self.videoNode?.zPosition = 32
            self.addChild(self.videoNode!)
            self.videoNode?.pause()
            
            self.barraControllerVideo.zPosition = 10
            self.controllerIcon.zPosition = 12
            self.controllerIcon.name = "controllerIcon"
            self.closeIcon.zPosition = 12
            self.closeIcon.name = "closeIcon"
            self.resetIcon.zPosition = 12
            self.resetIcon.name = "resetIcon"
            
            resetControllerVideo(open: false)
            
            self.videoNode.addChild(self.barraControllerVideo)
            self.videoNode.addChild(self.controllerIcon)
            self.videoNode.addChild(self.closeIcon)
            self.videoNode.addChild(self.resetIcon)

        }
        

       
        setGame()
       
    }
    
    @objc func bgVideoDidEnd(notification: NSNotification) {
        let playerItem = notification.object as! AVPlayerItem
        playerItem.seek(to: CMTime.zero, completionHandler: nil)
        videoNode?.pause()
    }
    
   
    
    func setGame() {
        self.nextButton?.isHidden = true
        
        self.choice = positions.randomElement()?.key
        self.label?.fontColor = UIColor.black
        self.label?.text = positions[self.choice]
        let splitPosition = positions[self.choice]!.split(separator: Character(("\n")), omittingEmptySubsequences: true)

        changeAudio(text: "\(splitPosition[0])")
        
    }
    

    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let point = touch.location(in: self)
            if videoNode.name == "closedVideo"{
                if self.atPoint(point).name == nextButton?.name{
                    self.nextButton?.run(SKAction.init(named: "Click")!)
                    setGame()
                }else if self.atPoint(point).name == self.videoThumb?.name{
                       openVideo()
                }else if let nameButton = self.atPoint(point).name{
                        if let position = positions[nameButton] {
                            self.atPoint(point).run(SKAction.init(named: "Click")!)
                            verifyResponse(nameButton: nameButton, position: position)
                        }
                    }
            }else{
                if self.atPoint(point).name == controllerIcon.name{
                    if videoIsPause{
                        self.controllerIcon.run(SKAction.setTexture(SKTexture(imageNamed: "PauseIcon.png")))
                        self.videoNode.play()
                        self.videoIsPause = false
                    }else{
                        self.controllerIcon.run(SKAction.setTexture(SKTexture(imageNamed: "PlayIcon.png")))
                        self.videoNode.pause()
                        self.videoIsPause = true
                    }
                }
                
                if self.atPoint(point).name == closeIcon.name{
                    closeVideo()
                }
                if self.atPoint(point).name == resetIcon.name{
                    self.bgVideoPlayer.seek(to: CMTime.zero)
                }
            }
            
            if self.atPoint(point).name == buttonAudio?.name{
                if !synthesizer.isSpeaking {
                    self.buttonAudio?.run(SKAction.init(named: "Click")!)
                    synthesizer.speak(utterance)
                }
            }
        }
    }
    
    func verifyResponse(nameButton:String, position:String){
        var text:String!
        var audioText:String!
        let splitPosition = position.split(separator: Character(("\n")), omittingEmptySubsequences: true)

        if choice == nameButton{
            self.chat?.run(SKAction.init(named: "Chat")!)
            
            self.label?.fontColor =  UIColor(red: 0.00, green: 0.50, blue: 0.25, alpha: 1.00)
            self.nextButton?.isHidden = false
            
            text = "Yes! That is \(position) "
            audioText = "Yes! That is \(splitPosition[0]) "

        }else{
            self.chat?.run(SKAction.init(named: "Chat")!)
            text = "Ops! That is \(position) "
            audioText = "Ops! That is \(splitPosition[0]) "

            self.label?.fontColor =  UIColor.red
        }
        self.label?.text = text
        changeAudio(text: audioText)
        if self.synthesizer.isSpeaking {self.synthesizer.stopSpeaking(at: .immediate)}
        self.synthesizer.speak(utterance)
    }
    
    func changeAudio(text:String){
        self.utterance = AVSpeechUtterance(string: text)
        self.utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        self.utterance.rate = 0.4
        self.utterance.pitchMultiplier = 1.5
        self.utterance.volume = 0.9
    }
    
    
    func openVideo() {
        self.audioMusic?.run(SKAction.pause())

           
        self.videoNode.run(SKAction.fadeAlpha(to: 1, duration: 1))
        self.videoNode.run(SKAction.moveTo(x: 0, duration: 1))
        self.videoNode.run(SKAction.moveTo(y: 2, duration: 1))
        self.videoNode.run(SKAction.resize(toWidth: 750, duration: 1))
        self.videoNode.run(SKAction.resize(toHeight: 500 , duration: 1))
        
        
        self.barraControllerVideo.size = CGSize(width: 750, height: 60)
        self.barraControllerVideo.position = CGPoint(x: 0, y:  self.videoNode.anchorPoint.y - 260)
        self.barraControllerVideo.zPosition = 9
                
        self.closeIcon.size = CGSize(width: 60, height: 60)
        self.closeIcon.position = CGPoint(x: self.barraControllerVideo.position.x + ( self.barraControllerVideo.size.width / 2.2) , y: self.videoNode.size.height + 60)
        
        self.controllerIcon.size = CGSize(width: 20, height: 20)
        self.controllerIcon.run(SKAction.setTexture(SKTexture(imageNamed: "PauseIcon.png")))
        self.controllerIcon.position = CGPoint(x: self.barraControllerVideo.position.x - ( self.barraControllerVideo.size.width / 2) + 40 , y: self.barraControllerVideo.position.y)

        self.resetIcon.size = CGSize(width: 30, height: 30)
        self.resetIcon.position = CGPoint(x: self.barraControllerVideo.position.x + ( self.barraControllerVideo.size.width / 2) - 40 , y: self.barraControllerVideo.position.y)
        
        resetControllerVideo(open: true)


        self.videoNode.play()
        self.videoIsPause = false
        self.videoNode.name = "openVideo"
        self.videoThumb?.run(SKAction.fadeAlpha(to: 0, duration: 1))
        
    }
    
    func closeVideo() {
        self.audioMusic?.run(SKAction.play())

        if let videoThumb = self.videoThumb {
            resetControllerVideo(open: false)

            
            self.videoNode.run(SKAction.fadeAlpha(to: 0, duration: 1))
            self.videoNode.run(SKAction.moveTo(x: videoThumb.position.x, duration: 1))
            self.videoNode.run(SKAction.moveTo(y: videoThumb.position.y, duration: 1))
            self.videoNode.run(SKAction.resize(toWidth: videoThumb.size.width, duration: 1))
            self.videoNode.run(SKAction.resize(toHeight: videoThumb.size.height , duration: 1))
            
            self.videoThumb?.run(SKAction.fadeAlpha(to: 1, duration: 1))
            
            self.barraControllerVideo.alpha = 0
            self.barraControllerVideo.isHidden = true

        }

        self.videoNode.name = "closedVideo"
        self.videoNode.pause()
        self.videoIsPause = true
    }
    
    
    func resetControllerVideo(open:Bool){
        if open {
            self.barraControllerVideo.alpha = 1
            self.controllerIcon.alpha = 1
            self.closeIcon.alpha = 1
            self.resetIcon.alpha = 1
            
            self.barraControllerVideo.isHidden = false
            self.controllerIcon.isHidden = false
            self.closeIcon.isHidden = false
            self.resetIcon.isHidden = false
        }else{
            self.barraControllerVideo.alpha = 0
            self.controllerIcon.alpha = 0
            self.closeIcon.alpha = 0
            self.resetIcon.alpha = 0
            
            self.barraControllerVideo.isHidden = true
            self.controllerIcon.isHidden = true
            self.closeIcon.isHidden = true
            self.resetIcon.isHidden = true
        }
    }
   
}
