//
//  XDUsersDefineViewController.swift
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/07/19.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

import UIKit

class XDUsersDefineViewController: UIViewController {
  var tableView: UITableView!
  private var defineButton:WSUIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()

    let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "onClickDoneButton:")
    self.navigationItem.title = "Config"
    self.navigationItem.setRightBarButtonItem(barButton, animated: true)


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
  
}
