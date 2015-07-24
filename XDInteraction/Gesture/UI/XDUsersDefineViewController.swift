//
//  XDUsersDefineViewController.swift
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/07/19.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

import UIKit

class XDUsersDefineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  var tableView: UITableView!
  private var userDefineCell: UsersDefineCell!
  private let nameNib:String = "UsersDefineCell"
  var model: XDUserDefineModel!

  func prepareForUse(model: XDUserDefineModel) {
    self.model = model
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()

    let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "onClickDoneButton:")
    self.navigationItem.title = "Config"
    self.navigationItem.setRightBarButtonItem(barButton, animated: true)

    tableView = UITableView(frame: self.view.frame)
    tableView.delegate = self
    tableView.dataSource = self

    let nib = UINib(nibName: nameNib, bundle: nil)
    tableView.registerNib(nib, forCellReuseIdentifier: nameNib)

    self.view.addSubview(tableView)
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  internal func onClickDoneButton(sender: UIButton) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }

  func changeUDInteraction(defineType: UserDefineType, selectedRow: Int) {
    println("\(defineType.hashValue) -> \(selectedRow)")
    model.changeInteraction(defineType, actionType: ActionType(rawValue: selectedRow)!)
  }

  // MARK: - UITableViewDataSource
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return UserDefineType.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell:UsersDefineCell = tableView.dequeueReusableCellWithIdentifier(nameNib, forIndexPath: indexPath) as! UsersDefineCell

    switch indexPath.row {
    case 0:
      cell.title = UserDefineType.GyroUp.rawValue
      cell.defineType = .GyroUp
      if let row = model.userDefineDictionary[.GyroUp]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.GyroUp, selectedRow: selectedRow)
      }
    case 1:
      cell.title = UserDefineType.GyroDown.rawValue
      cell.defineType = .GyroDown
      if let row = model.userDefineDictionary[.GyroDown]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.GyroDown, selectedRow: selectedRow)
      }
    case 2:
      cell.title = UserDefineType.PinchIn.rawValue
      cell.defineType = .PinchIn
      if let row = model.userDefineDictionary[.PinchIn]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.PinchIn, selectedRow: selectedRow)
      }
    case 3:
      cell.title = UserDefineType.PinchOut.rawValue
      cell.defineType = .PinchOut
      if let row = model.userDefineDictionary[.PinchOut]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.PinchOut, selectedRow: selectedRow)
      }
    case 4:
      cell.title = UserDefineType.SwipeUp.rawValue
      cell.defineType = .SwipeUp
      if let row = model.userDefineDictionary[.SwipeUp]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.SwipeUp, selectedRow: selectedRow)
      }
    case 5:
      cell.title = UserDefineType.SwipeDown.rawValue
      cell.defineType = .SwipeDown
      if let row = model.userDefineDictionary[.SwipeDown]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.SwipeDown, selectedRow: selectedRow)
      }
    case 6:
      cell.title = UserDefineType.SwipeLeft.rawValue
      cell.defineType = .SwipeLeft
      if let row = model.userDefineDictionary[.SwipeLeft]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.SwipeLeft, selectedRow: selectedRow)
      }
    case 7:
      cell.title = UserDefineType.SwipeRight.rawValue
      cell.defineType = .SwipeRight
      if let row = model.userDefineDictionary[.SwipeRight]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.SwipeRight, selectedRow: selectedRow)
      }
    case 8:
      cell.title = UserDefineType.SingleTap.rawValue
      cell.defineType = .SingleTap
      if let row = model.userDefineDictionary[.SingleTap]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.SingleTap, selectedRow: selectedRow)
      }
    case 9:
      cell.title = UserDefineType.DoubleTap.rawValue
      cell.defineType = .DoubleTap
      if let row = model.userDefineDictionary[.DoubleTap]?.rawValue {
        cell.dataPicker.selectRow(row, inComponent: 0, animated: false)
      }
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.DoubleTap, selectedRow: selectedRow)
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
