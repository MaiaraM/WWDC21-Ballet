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


public class GameBaseScene: SKScene {
  
    private var videoThumb : SKSpriteNode!
    private var videoIsPause:Bool = true

    
    private var bgVideoPlayer:AVPlayer!
    private var videoNode:SKVideoNode!
    private var barraControllerVideo =  SKSpriteNode(color: SKColor.white, size: CGSize(width: 20, height: 20))
    
    private var controllerIcon = SKSpriteNode(imageNamed: "PauseIcon.png")
    private var resetIcon = SKSpriteNode(imageNamed: "ResetIcon.png")


    public override func didMove(to view: SKView) {
        self.videoNode?.pause()
    }
    
    public override func sceneDidLoad() {
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
            self.resetIcon.zPosition = 12
            self.resetIcon.name = "resetIcon"

            
            
            resetControllerVideo(open: false)
            
            self.videoNode.addChild(self.barraControllerVideo)
            self.videoNode.addChild(self.controllerIcon)
            self.videoNode.addChild(self.resetIcon)

        }
    }
    
    @objc func bgVideoDidEnd(notification: NSNotification) {
        let playerItem = notification.object as! AVPlayerItem
        playerItem.seek(to: CMTime.zero, completionHandler: nil)
        videoNode?.pause()
    }
    
   
    

    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let point = touch.location(in: self)
            if videoNode.name == "closedVideo"{
                if self.atPoint(point).name == self.videoThumb?.name{
                       openVideo()
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
                if self.atPoint(point).name == resetIcon.name{
                    self.bgVideoPlayer.seek(to: CMTime.zero)
                }
            }
            
        }
    }
       
    
    func openVideo() {
        self.videoNode.run(SKAction.fadeAlpha(to: 1, duration: 1))
        self.videoNode.run(SKAction.moveTo(x: 0, duration: 1))
        self.videoNode.run(SKAction.moveTo(y: 2, duration: 1))
        self.videoNode.run(SKAction.resize(toWidth: self.videoThumb.size.width, duration: 1))
        self.videoNode.run(SKAction.resize(toHeight: self.frame.size.height / 2 , duration: 1))
                
        self.barraControllerVideo.size = CGSize(width: self.videoThumb.size.width, height: 60)
        self.barraControllerVideo.position = CGPoint(x: 0, y:  self.videoNode.position.y - (self.videoNode.size.height / 2) - 10)
        self.barraControllerVideo.zPosition = 9
        
        self.controllerIcon.size = CGSize(width: 20, height: 20)
        self.controllerIcon.run(SKAction.setTexture(SKTexture(imageNamed: "PauseIcon.png")))
        self.controllerIcon.position = CGPoint(x: self.frame.minX + 60, y: self.barraControllerVideo.position.y)
        
        
        self.resetIcon.size = CGSize(width: 30, height: 30)
        self.resetIcon.position = CGPoint(x: self.barraControllerVideo.position.x + ( self.barraControllerVideo.size.width / 2) - 40 , y: self.barraControllerVideo.position.y)
        
        resetControllerVideo(open: true)


        self.videoNode.play()
        self.videoIsPause = false
        self.videoNode.name = "openVideo"
        self.videoThumb?.run(SKAction.fadeAlpha(to: 0, duration: 1))
    }
    
    
    
    func resetControllerVideo(open:Bool){
        if open {
            self.barraControllerVideo.alpha = 1
            self.controllerIcon.alpha = 1
            self.resetIcon.alpha = 1
            
            self.barraControllerVideo.isHidden = false
            self.controllerIcon.isHidden = false
            self.resetIcon.isHidden = false
        }else{
            self.barraControllerVideo.alpha = 0
            self.controllerIcon.alpha = 0
            self.resetIcon.alpha = 0
            
            self.barraControllerVideo.isHidden = true
            self.controllerIcon.isHidden = true
            self.resetIcon.isHidden = true
        }
    }
   
}
