//
//  XDUsersDefineViewController.swift
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/07/19.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

import UIKit

class XDUsersDefineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  var tableView: UITableView?
  private var userDefineCell: UsersDefineCell?
  private let nameNib:String = "UsersDefineCell"
  var model: XDUserDefineModel!
  var bipMessageSendBlock: (String -> Void)?
  var userName: String?
  
  func prepareForUse(model: XDUserDefineModel, userName: String) {
    self.model = model
    self.userName = userName
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()

    let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "onClickDoneButton:")
    self.navigationItem.title = "Config"
    self.navigationItem.setRightBarButtonItem(barButton, animated: true)

    tableView = UITableView(frame: self.view.frame)
    tableView!.delegate = self
    tableView!.dataSource = self

    let nib = UINib(nibName: nameNib, bundle: nil)
    tableView!.registerNib(nib, forCellReuseIdentifier: nameNib)

    self.view!.addSubview(tableView!)
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  internal func onClickDoneButton(sender: UIButton) {
    let jsonMessage = model.getBIPJsonMessage(userName ?? "No Name")
    if let bipMessageSendBlock = bipMessageSendBlock {
      bipMessageSendBlock(jsonMessage)
    }
    self.dismissViewControllerAnimated(true, completion: nil)
  }

  func changeUDInteraction(defineType: UserDefineType, selectedRow: Int) {
    model.changeInteraction(defineType, actionType: ActionType(rawValue: selectedRow)!)
  }
  
  func changeWindowSelect(defineType: UserDefineType, value: Int) {
    model.changeWindow(defineType, window: value)
  }

  // MARK: - UITableViewDataSource
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return UserDefineType.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell:UsersDefineCell = tableView.dequeueReusableCellWithIdentifier(nameNib, forIndexPath: indexPath) as! UsersDefineCell
//    let cell = UsersDefineCell()

    switch indexPath.row {
    case 0:
      cell.title = UserDefineType.PinchIn.rawValue
      cell.defineType = .PinchIn
      cell.windowSegmentedControl.selectedSegmentIndex = model.defineWindowDictionary[.PinchIn] ?? 0
      if let row = model.userDefineDictionary[.PinchIn]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.PinchIn, selectedRow: selectedRow)
      }
      cell.segmentedControlChangedBlock = {(selectedRow: Int, value: Int) in
        self.changeWindowSelect(.PinchIn, value: value)
      }
    case 1:
      cell.title = UserDefineType.PinchOut.rawValue
      cell.defineType = .PinchOut
      cell.windowSegmentedControl.selectedSegmentIndex = model.defineWindowDictionary[.PinchOut] ?? 0
      if let row = model.userDefineDictionary[.PinchOut]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.PinchOut, selectedRow: selectedRow)
      }
      cell.segmentedControlChangedBlock = {(selectedRow: Int, value: Int) in
        self.changeWindowSelect(.PinchOut, value: value)
      }
    case 2:
      cell.title = UserDefineType.SwipeUp.rawValue
      cell.defineType = .SwipeUp
      cell.windowSegmentedControl.selectedSegmentIndex = model.defineWindowDictionary[.SwipeUp] ?? 0
      if let row = model.userDefineDictionary[.SwipeUp]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.SwipeUp, selectedRow: selectedRow)
      }
      cell.segmentedControlChangedBlock = {(selectedRow: Int, value: Int) in
        self.changeWindowSelect(.SwipeUp, value: value)
      }
    case 3:
      cell.title = UserDefineType.SwipeDown.rawValue
      cell.defineType = .SwipeDown
      cell.windowSegmentedControl.selectedSegmentIndex = model.defineWindowDictionary[.SwipeDown] ?? 0
      if let row = model.userDefineDictionary[.SwipeDown]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.SwipeDown, selectedRow: selectedRow)
      }
      cell.segmentedControlChangedBlock = {(selectedRow: Int, value: Int) in
        self.changeWindowSelect(.SwipeDown, value: value)
      }
    case 4:
      cell.title = UserDefineType.SwipeLeft.rawValue
      cell.defineType = .SwipeLeft
      cell.windowSegmentedControl.selectedSegmentIndex = model.defineWindowDictionary[.SwipeLeft] ?? 0
      if let row = model.userDefineDictionary[.SwipeLeft]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.SwipeLeft, selectedRow: selectedRow)
      }
      cell.segmentedControlChangedBlock = {(selectedRow: Int, value: Int) in
        self.changeWindowSelect(.SwipeLeft, value: value)
      }
    case 5:
      cell.title = UserDefineType.SwipeRight.rawValue
      cell.defineType = .SwipeRight
      cell.windowSegmentedControl.selectedSegmentIndex = model.defineWindowDictionary[.SwipeRight] ?? 0
      if let row = model.userDefineDictionary[.SwipeRight]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.SwipeRight, selectedRow: selectedRow)
      }
      cell.segmentedControlChangedBlock = {(selectedRow: Int, value: Int) in
        self.changeWindowSelect(.SwipeRight, value: value)
      }
    case 6:
      cell.title = UserDefineType.SingleTap.rawValue
      cell.defineType = .SingleTap
      cell.windowSegmentedControl.selectedSegmentIndex = model.defineWindowDictionary[.SingleTap] ?? 0
      if let row = model.userDefineDictionary[.SingleTap]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.SingleTap, selectedRow: selectedRow)
      }
      cell.segmentedControlChangedBlock = {(selectedRow: Int, value: Int) in
        self.changeWindowSelect(.SingleTap, value: value)
      }
    case 7:
      cell.title = UserDefineType.DoubleTap.rawValue
      cell.defineType = .DoubleTap
      cell.windowSegmentedControl.selectedSegmentIndex = model.defineWindowDictionary[.DoubleTap] ?? 0
      if let row = model.userDefineDictionary[.DoubleTap]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.DoubleTap, selectedRow: selectedRow)
      }
      cell.segmentedControlChangedBlock = {(selectedRow: Int, value: Int) in
        self.changeWindowSelect(.DoubleTap, value: value)
      }
    case 8:
      cell.title = UserDefineType.ButtonLeft.rawValue
      cell.defineType = .ButtonLeft
      cell.windowSegmentedControl.selectedSegmentIndex = model.defineWindowDictionary[.ButtonLeft] ?? 0
      if let row = model.userDefineDictionary[.ButtonLeft]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.ButtonLeft, selectedRow: selectedRow)
      }
      cell.segmentedControlChangedBlock = {(selectedRow: Int, value: Int) in
        self.changeWindowSelect(.ButtonLeft, value: value)
      }
    case 9:
      cell.title = UserDefineType.ButtonRight.rawValue
      cell.defineType = .ButtonRight
      cell.windowSegmentedControl.selectedSegmentIndex = model.defineWindowDictionary[.ButtonRight] ?? 0
      if let row = model.userDefineDictionary[.ButtonRight]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.ButtonRight, selectedRow: selectedRow)
      }
      cell.segmentedControlChangedBlock = {(selectedRow: Int, value: Int) in
        self.changeWindowSelect(.ButtonRight, value: value)
      }
    default:
      break
    }

    return cell
  }

  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 162
  }
}
