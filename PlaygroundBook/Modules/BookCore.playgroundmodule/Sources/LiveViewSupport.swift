//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import PlaygroundSupport


public enum StoryBoards : String{
    case baseStory = "IntroBaseView"
    case explanationStory = "LiveView"
    case gameBaseStory = "GameBaseView"
    case gameStory = "GameView"
}


/// Instantiates a new instance of a live view.
///
/// By default, this loads an instance of `LiveViewController` from `LiveView.storyboard`.
public func instantiateLiveView(_ storyBoard:StoryBoards = .baseStory) -> PlaygroundLiveViewable {
    let storyboard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)

    guard let viewController = storyboard.instantiateInitialViewController() else {
        fatalError("LiveView.storyboard does not have an initial scene; please set one or update this function")
    }

    guard let liveViewController = viewController as? LiveViewController else {
        fatalError("LiveView.storyboard's initial scene is not a LiveViewController; please either update the storyboard or this function")
    }

    return liveViewController
}

