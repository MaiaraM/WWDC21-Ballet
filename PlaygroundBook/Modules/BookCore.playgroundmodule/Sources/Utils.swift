//
//  Utils.swift
//  BasicBallet
//
//  Created by Maiara Martins on 06/04/21.
//

import Foundation

import SpriteKit


public struct Dialogue{
    var text:String!
    var audio:String!
    var action:SKAction?
}

public let dialoguesHistory: [Dialogue] = [
    Dialogue(text: "Hi! I am Maiara! \nNice to Meet you!",audio: "music.mp3" , action: SKAction.init(named: "D1")),
    Dialogue(text: "I'll be your ballet teacher.", audio: "music.mp3" , action: SKAction.init(named: "D1")),
    Dialogue(text: "In this chapter I will teach the 5 main positions of Ballet.", audio: "music.mp3" , action: SKAction.init(named: "D2")),
    Dialogue(text: "Are you excited for the first steps?", audio: "music.mp3" , action: SKAction.init(named: "D2")),
    Dialogue(text: "Great! I'm really excited too!.",audio: "music.mp3" ,  action: SKAction.init(named: "D1")!),
    Dialogue(text: "For that I need you to practice with me",audio: "music.mp3" ,  action: SKAction.init(named: "D2")),
    Dialogue(text: "Stand up and don't forget to always stretch your knees", audio: "music.mp3" , action: SKAction.init(named: "D2")),
    Dialogue(text: "Let's start!", audio: "music.mp3" , action: SKAction.init(named: "D1")),
]

public let textGame: [Dialogue] = [
    Dialogue(text:  "In this game I will say a position and you must choose which position I am saying",audio: "music.mp3"),
    Dialogue(text: "To help I made a video for you to remember the positions.",audio: "music.mp3"),
    Dialogue(text:  "You can watch whenever you want and as many times as you want",audio: "music.mp3"),
    Dialogue(text:  "are you ready? Let's start!",audio: "music.mp3"),
]

public let positions:[String:String] = [
    "button1": "\n First Position. \n (1st position)",
    "button2": "\n Second Position.\n (2nd position)",
    "button3": "\n Third Position. \n(3rd position)",
    "button4": "\n Fourth Position.\n (4th Position)",
    "button5": "\n Fifth Position.\n (5th Position)",
]

public struct Step{
    var text:String!
    var number:Int?
    var actionsRight:SKAction?
    var actionsLeft:SKAction?
}


let defaultDuration = 1.0

let rotateRight:SKAction = SKAction.rotate(toAngle: -.pi / 2.8, duration: 1)
let rotateLeft:SKAction = SKAction.rotate(toAngle: .pi / 2.8, duration: 1)


public func addSteps(beganRight : Array<CGFloat>, beganLeft: Array<CGFloat>) -> [Step]  {
    return [
        //
        Step(text: "Follow the steps with me.",
             actionsRight: SKAction.sequence([
                SKAction.move(to: CGPoint(x: beganRight[0],y: beganRight[1]), duration: defaultDuration),
                SKAction.rotate(toAngle: 0, duration: defaultDuration)
             ]),
             actionsLeft: SKAction.sequence([
                SKAction.move(to: CGPoint(x: beganLeft[0] ,y: beganLeft[1]), duration: defaultDuration),
                SKAction.rotate(toAngle: 0, duration: defaultDuration)
             ])),
        
        
        
        
        // 1
        Step(text: "Open your feet like scissors.",
             actionsRight: SKAction.sequence([ SKAction.move(to: CGPoint(x: beganRight[0] + 8,y: beganRight[1]), duration: defaultDuration), rotateRight]),
             actionsLeft: SKAction.sequence([ SKAction.move(to: CGPoint(x: beganLeft[0] - 8,y: beganLeft[1]), duration: defaultDuration),rotateLeft])),
        Step(text: "This is the First Position. (1st position)",
             number: 1,
             actionsRight: SKAction.sequence([ SKAction.move(to: CGPoint(x: beganRight[0] + 8,y: beganRight[1]), duration: defaultDuration), rotateRight]),
             actionsLeft: SKAction.sequence([ SKAction.move(to: CGPoint(x: beganLeft[0] - 8,y: beganLeft[1]), duration: defaultDuration),rotateLeft])),
        
        
        
        //2
        Step(text: "Next separate your feet and feathers as if it were a tunnel.",
             actionsRight: SKAction.sequence([SKAction.move(to: CGPoint(x: beganRight[0] + 80,y: beganRight[1]), duration: defaultDuration), ]),
             actionsLeft: SKAction.sequence([ SKAction.move(to: CGPoint(x: beganLeft[0] - 80,y: beganLeft[1]), duration: defaultDuration)])),
        Step(text: "This is the Second Position. (2nd position)",
             number: 2,
             actionsRight: SKAction.sequence([SKAction.move(to: CGPoint(x: beganRight[0] + 80,y: beganRight[1]), duration: defaultDuration), ]),
             actionsLeft: SKAction.sequence([ SKAction.move(to: CGPoint(x: beganLeft[0] - 80,y: beganLeft[1]), duration: defaultDuration)])),
        
        Step(text: "The next one, you need to put one foot in front of the other "),
        
        // 3
        Step(text: "The front foot should be in the middle of the back foot.",
             actionsRight: SKAction.sequence([ SKAction.move(to: CGPoint(x: beganRight[0] - 45,y: beganRight[1] + 40), duration: defaultDuration)]),
             actionsLeft: SKAction.sequence([ SKAction.move(to: CGPoint(x: beganLeft[0] + 40,y: beganLeft[1] - 30), duration: defaultDuration)])),
        Step(text: "This is the Third Position. (3rd position)",
             number: 3,
             actionsRight: SKAction.sequence([ SKAction.move(to: CGPoint(x: beganRight[0] - 45,y: beganRight[1] + 40), duration: defaultDuration)]),
             actionsLeft: SKAction.sequence([ SKAction.move(to: CGPoint(x: beganLeft[0] + 40,y: beganLeft[1] - 30), duration: defaultDuration)])),
        

        
        Step(text: "Very good! You are doing great!"),

        
        //4
        Step(text: "Now put your front foot a little bit forward, separating your legs.",
             actionsRight: SKAction.sequence([rotateRight, SKAction.move(to: CGPoint(x: beganRight[0] - 45,y: beganRight[1] + 140), duration: defaultDuration)]),
             actionsLeft: SKAction.sequence([rotateLeft, SKAction.move(to: CGPoint(x: beganLeft[0] + 45,y: beganLeft[1] - 25), duration: defaultDuration)])),
        Step(text: "This is the Fourth Position. (4th Position)",
             number: 4,
             actionsRight: SKAction.sequence([rotateRight, SKAction.move(to: CGPoint(x: beganRight[0] - 45,y: beganRight[1] + 140), duration: defaultDuration)]),
             actionsLeft: SKAction.sequence([rotateLeft, SKAction.move(to: CGPoint(x: beganLeft[0] + 45,y: beganLeft[1] - 25), duration: defaultDuration)])),
        
        
        Step(text: "The next is the last position!"),
        
        //5
        Step(text: "You must put one foot in front of the other and hide the one behind.",
             actionsRight: SKAction.sequence([SKAction.rotate(toAngle: -.pi / 2.5, duration: 0.5),
                                              SKAction.move(to: CGPoint(x: beganRight[0] - 85,y: beganRight[1] + 60), duration: defaultDuration)]),
             actionsLeft: SKAction.sequence([SKAction.rotate(toAngle: .pi / 2.5, duration: 0.5), SKAction.move(to: CGPoint(x: beganLeft[0] + 85,y: beganLeft[1] - 45), duration: defaultDuration)])),
        Step(text: "Like This! \n \n  This is the  Fifth Position. (5th Position)",
             number: 5,
             actionsRight: SKAction.sequence([SKAction.rotate(toAngle: -.pi / 2.5, duration: 0.5),
                                              SKAction.move(to: CGPoint(x: beganRight[0] - 85,y: beganRight[1] + 60), duration: defaultDuration)]),
             actionsLeft: SKAction.sequence([SKAction.rotate(toAngle: .pi / 2.5, duration: 0.5), SKAction.move(to: CGPoint(x: beganLeft[0] + 85,y: beganLeft[1] - 45), duration: defaultDuration)])),
        Step(text: "Congratulations! You learn the 5 positions of Ballet!"),
        Step(text: "Go to the next chapter!"),
    ]
}
