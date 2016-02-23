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
  case ButtonLeft = "ButtonLeft"
  case ButtonRight = "ButtonRight"

  static let count = 12
  static let allValues = ["GyroUp", "GyroDown", "PinchIn", "PinchOut", "SwipeUp", "SwipeDown", "SwipeLeft", "SwipeRight", "SingleTap", "DoubleTap", "ButtonLeft", "ButtonRight"]
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
      return "Size Up"
    case .ZoomOut:
      return "Size Down"
    case .TextBig:
      return "Text Big"
    case .TextSmall:
      return "Text Small"
    case .NextPage:
      return "Next Page"
    case .BackPage:
      return "Back Page"
    case .NoGesture:
      return "No Gesture"
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
    userDefineDictionary[.GyroUp] = .ScrollUp
    userDefineDictionary[.GyroDown] = .ScrollDown
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
