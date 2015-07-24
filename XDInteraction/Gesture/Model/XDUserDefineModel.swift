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
  case ScrollUp = 0
  case ScrollDown = 1
  case ZoomIn = 2
  case ZoomOut = 3
  case TextBig = 4
  case TextSmall = 5
  case NextPage = 6
  case NoGesture = 7

  func toString() -> String {
    switch self {
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
    default:
      return "No Gesture"
    }
  }

  static let count = 8
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

  func checkSameActionType() -> Bool {
    var result:Bool = false

    for (defineType, actionType) in userDefineDictionary {
      for (fdefineType, factionType) in userDefineDictionary {
        if defineType == fdefineType {
          continue
        }
        if actionType == factionType {
          result = true
          break
        }
      }
      if result {
        break
      }
    }

    return result
  }
}
