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
  private let tableViewValue: NSArray = ["Gyro Up", "Gyro Down", "Pinch In", "Pinch Out", "Button A", "Button B", "Button C", "Button D"]
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
    return tableViewValue.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell:UsersDefineCell = tableView.dequeueReusableCellWithIdentifier(nameNib, forIndexPath: indexPath) as! UsersDefineCell
    var title: String = ""
    switch indexPath.row {
    case 0:
      title = tableViewValue[0] as! String
      cell.defineType = .GyroUp
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.GyroUp, selectedRow: selectedRow)
      }
    case 1:
      title = tableViewValue[1] as! String
      cell.defineType = .GyroDown
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.GyroDown, selectedRow: selectedRow)
      }
    case 2:
      title = tableViewValue[2] as! String
      cell.defineType = .PinchIn
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.PinchIn, selectedRow: selectedRow)
      }
    case 3:
      title = tableViewValue[3] as! String
      cell.defineType = .PinchOut
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.PinchOut, selectedRow: selectedRow)
      }
    case 4:
      title = tableViewValue[4] as! String
      cell.defineType = .ButtonA
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.ButtonA, selectedRow: selectedRow)
      }
    case 5:
      title = tableViewValue[5] as! String
      cell.defineType = .ButtonB
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.ButtonB, selectedRow: selectedRow)
      }
    case 6:
      title = tableViewValue[6] as! String
      cell.defineType = .ButtonC
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.ButtonC, selectedRow: selectedRow)
      }
    case 7:
      title = tableViewValue[7] as! String
      cell.defineType = .ButtonD
      cell.userDefinePickerChangedBlock = {(selectedRow: Int) in
        self.changeUDInteraction(.ButtonD, selectedRow: selectedRow)
      }
    default:
      break
    }
    cell.title = title
    return cell
  }

  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 162
  }

}
