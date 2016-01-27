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
  case ButtonLeft = "buttonLeft"
  case ButtonRight = "buttonRight"

  static let count = 12
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
  case NoGesture = 8

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
    }
  }

  static let count = 9
}

class XDUserDefineModel: NSObject {
  var userDefineDictionary: Dictionary<UserDefineType, ActionType>!
  var defineWindowDictionary: Dictionary<UserDefineType, Int>!

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
    userDefineDictionary[.ButtonLeft] = .NoGesture
    userDefineDictionary[.ButtonRight] = .NoGesture
    
    defineWindowDictionary = Dictionary<UserDefineType, Int>()
    defineWindowDictionary[.GyroUp] = 0
    defineWindowDictionary[.GyroDown] = 0
    defineWindowDictionary[.PinchIn] = 0
    defineWindowDictionary[.PinchOut] = 0
    defineWindowDictionary[.SwipeUp] = 0
    defineWindowDictionary[.SwipeDown] = 0
    defineWindowDictionary[.SwipeLeft] = 0
    defineWindowDictionary[.SwipeRight] = 0
    defineWindowDictionary[.SingleTap] = 0
    defineWindowDictionary[.DoubleTap] = 0
    defineWindowDictionary[.ButtonLeft] = 0
    defineWindowDictionary[.ButtonRight] = 0

    super.init()
  }

  func changeInteraction(defineType: UserDefineType, actionType: ActionType) {
    userDefineDictionary.updateValue(actionType, forKey: defineType) 
  }

  func getAction(gestureType: String) -> Int {
    return userDefineDictionary[UserDefineType(rawValue: gestureType)!]!.hashValue
  }
  
  func getButtonLeftActionTitle() -> String {
    return  userDefineDictionary[.ButtonLeft]?.toString() ?? "No Gesture"
  }
  
  func getButtonRightActionTitle() -> String {
    return  userDefineDictionary[.ButtonRight]?.toString() ?? "No Gesture"
  }
  
  func changeWindow(defineType: UserDefineType, window: Int) {
    defineWindowDictionary.updateValue(window, forKey: defineType)
  }

  func getWindow(gestureType: String) -> String {
    switch defineWindowDictionary[UserDefineType(rawValue: gestureType)!]!.hashValue {
    case 0:
      return "1"
    case 1:
      return "2"
    case 2:
      return "both"
    default:
      return "1"
    }
  }
}
