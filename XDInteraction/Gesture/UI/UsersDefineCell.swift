//
//  UsersDefineCell.swift
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/07/20.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

import UIKit

class UsersDefineCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
  @IBOutlet weak var cellLabel: UILabel!
  @IBOutlet weak var dataPicker: UIPickerView!
  var pickerValue: Int!
  private var superTableView: UITableView!
  var defineType: UserDefineType!
  var userDefinePickerChangedBlock: ((selectedRow: Int) -> Void)?
  private let pickerValues:NSArray = ["Scroll Up", "Scroll Down", "Zoom In", "Zoom Out", "Text Big", "Text Small", "Next Page"]

  func prepareForTableView(tableView: UITableView) {
    superTableView = tableView
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    dataPicker.delegate = self
    dataPicker.dataSource = self
  }

  override func setSelected(selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
  }

  var title: String = "" {
    didSet {
      cellLabel.text = title
    }
  }

// MARK: - UIPickerViewDataSource
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerValues.count
  }

  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    return pickerValues[row] as! String
  }

  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    println("row \(row)")
    pickerValue = row
    if let userDefinePickerChangedBlock = userDefinePickerChangedBlock {
      userDefinePickerChangedBlock(selectedRow: row)
    }
  }

}
