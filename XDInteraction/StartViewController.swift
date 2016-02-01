//
//  StartViewController.swift
//  XDInteraction
//
//  Created by FumikoIshizawa on 2016/02/01.
//  Copyright © 2016年 FumikoIshiawa. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
  @IBOutlet weak var userNameTextField: UITextField!
  @IBOutlet weak var addressTextField: UITextField!
  var userNameChangeBlock: (String -> Void)?
  var addressChangeBlock: (String -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func submitButtonTouchUpInside(sender: UIButton) {
    if let userNameChangeBlock = userNameChangeBlock {
      var name = userNameTextField.text ?? "No Name"
      name = name == "" ? "No Name" : name
      userNameChangeBlock(name)
    }
    if let addressChangeBlock = addressChangeBlock {
      var text = addressTextField.text ?? "localhost"
      text = text == "" ? "localhost" : text
      addressChangeBlock(text)
    }
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func onReturn(sender: AnyObject) {
  }
  
  @IBAction func addressOnReturn(sender: AnyObject) {
  }
}
