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
  case ButtonA = "ButtonA"
  case ButtonB = "ButtonB"
  case ButtonC = "ButtonC"
  case ButtonD = "ButtonD"
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
}

class XDUserDefineModel: NSObject {
  var userDefineDictionary: Dictionary<UserDefineType, ActionType>!

  override init() {
    userDefineDictionary = Dictionary<UserDefineType, ActionType>()
    userDefineDictionary[.GyroUp] = .ScrollUp
    userDefineDictionary[.GyroDown] = .ScrollDown
    userDefineDictionary[.PinchIn] = .ZoomIn
    userDefineDictionary[.PinchOut] = .ZoomOut
    userDefineDictionary[.ButtonA] = .TextBig
    userDefineDictionary[.ButtonB] = .TextSmall
    userDefineDictionary[.ButtonC] = .NextPage
    userDefineDictionary[.ButtonD] = .NoGesture
    super.init()
  }

  func changeInteraction(defineType: UserDefineType, actionType: ActionType) {
    userDefineDictionary.updateValue(actionType, forKey: defineType)
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
