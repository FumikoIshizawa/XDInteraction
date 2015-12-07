//
//  XDUserDefineModel.swift
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/07/23.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

enum UserDefineType: String {
  case GyroUp = "GyroUp"
  case GyroDown = "GyroDown"
  case PinchIn = "PinchIn"
  case PinchOut = "PinchOut"
  case SwipeUp = "SwipeUp"
  case SwipeDown = "SwipeDown"
  case SwipeLeft = "SwipeLeft"
  case SwipeRight = "SwipeRight"
  case SingleTap = "SingleTap"
  case DoubleTap = "DoubleTap"

  static let count = 10
}

enum ActionType: Int {
  case Click = 0
  case ScrollUp = 1
  case ScrollDown = 2
  case ZoomIn = 3
  case ZoomOut = 4
  case TextBig = 5
  case TextSmall = 6
  case NextPage = 7
  case SwitchWindow = 8
  case NoGesture = 9

  func toString() -> String {
    switch self {
    case .Click:
      return "Click"
    case .ScrollUp:
      return "Scroll Up"
    case .ScrollDown:
      return "Scroll Down"
    case .ZoomIn:
      return "Zoom In"
    case .ZoomOut:
      return "Zoom Out"
    case .TextBig:
      return "Text Big"
    case .TextSmall:
      return "Text Small"
    case .NextPage:
      return "Next Page"
    case .NoGesture:
      return "No Gesture"
    case .SwitchWindow:
      return "Switch Window"
    }
  }

  static let count = 10
}

class XDUserDefineModel: NSObject {
  var userDefineDictionary: Dictionary<UserDefineType, ActionType>!

  override init() {
    userDefineDictionary = Dictionary<UserDefineType, ActionType>()
    userDefineDictionary[.GyroUp] = .ScrollUp
    userDefineDictionary[.GyroDown] = .ScrollDown
    userDefineDictionary[.PinchIn] = .ZoomIn
    userDefineDictionary[.PinchOut] = .ZoomOut
    userDefineDictionary[.SwipeUp] = .TextBig
    userDefineDictionary[.SwipeDown] = .TextSmall
    userDefineDictionary[.SwipeLeft] = .NextPage
    userDefineDictionary[.SwipeRight] = .NoGesture
    userDefineDictionary[.SingleTap] = .NoGesture
    userDefineDictionary[.DoubleTap] = .NoGesture

    super.init()
  }

  func changeInteraction(defineType: UserDefineType, actionType: ActionType) {
    userDefineDictionary.updateValue(actionType, forKey: defineType) 
  }

  func getAction(gestureType: String) -> Int {
    return userDefineDictionary[UserDefineType(rawValue: gestureType)!]!.hashValue
  }

}
