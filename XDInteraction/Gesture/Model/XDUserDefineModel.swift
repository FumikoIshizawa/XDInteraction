//
//  XDUserDefineModel.swift
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/07/23.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

enum UserDefineType: String {
  case PinchIn = "Pinch In"
  case PinchOut = "Pinch Out"
  case SwipeUp = "Swipe Up"
  case SwipeDown = "Swipe Down"
  case SwipeLeft = "Swipe Left"
  case SwipeRight = "Swipe Right"
  case SingleTap = "Tap"
  case DoubleTap = "Double Tap"
  case ButtonLeft = "Button Left"
  case ButtonRight = "Button Right"

  static let count = 8
  static let allValues = ["Pinch In", "Pinch Out", "Swipe Up", "Swipe Down", "Swipe Left", "Swipe Right", "Tap", "Double Tap", "Button Left", "Button Right"]
}

enum ActionType: Int {
  case ScrollUp = 0
  case ScrollDown = 1
  case ZoomIn = 2
  case ZoomOut = 3
  case TextBig = 4
  case TextSmall = 5
  case NextPage = 6
  case BackPage = 7
  case NoGesture = 8

  func toString() -> String {
    switch self {
    case .ScrollUp:
      return "Scroll Up"
    case .ScrollDown:
      return "Scroll Down"
    case .ZoomIn:
      return "Increase Size"
    case .ZoomOut:
      return "Decrease Size"
    case .TextBig:
      return "Increase Text Size"
    case .TextSmall:
      return "Decrease Text Size"
    case .NextPage:
      return "Next Page"
    case .BackPage:
      return "Previous Page"
    case .NoGesture:
      return "Null"
    }
  }

  static let count = 9
}

class XDUserDefineModel: NSObject {
  var userDefineDictionary: Dictionary<UserDefineType, ActionType>!
  var defineWindowDictionary: Dictionary<UserDefineType, Int>!
  var jsonMessage: String?

  override init() {
    userDefineDictionary = Dictionary<UserDefineType, ActionType>()
    userDefineDictionary[.PinchIn] = .ZoomIn
    userDefineDictionary[.PinchOut] = .ZoomOut
    userDefineDictionary[.SwipeUp] = .TextBig
    userDefineDictionary[.SwipeDown] = .TextSmall
    userDefineDictionary[.SwipeLeft] = .NextPage
    userDefineDictionary[.SwipeRight] = .BackPage
    userDefineDictionary[.SingleTap] = .NoGesture
    userDefineDictionary[.DoubleTap] = .NoGesture
    userDefineDictionary[.ButtonLeft] = .NoGesture
    userDefineDictionary[.ButtonRight] = .NoGesture
    
    defineWindowDictionary = Dictionary<UserDefineType, Int>()
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
    
    jsonMessage = getBIPJsonMessage("No Name")
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
  
  func getBIPJsonMessage(userName: String) -> String {
    var obj = Dictionary<String, AnyObject>()
    obj["type"] = "bip"
    obj["origin"] = userName
    
    for type in UserDefineType.allValues {
      obj[type] = ["action": userDefineDictionary[UserDefineType(rawValue: type)!]!.toString() ?? "No Gesture", "window": defineWindowDictionary[UserDefineType(rawValue: type)!]! ?? 0]
    }
    
    print(obj)
    let json = JSON(obj)
    return json.toString()
  }
}
