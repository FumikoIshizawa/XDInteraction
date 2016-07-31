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
  var segmentedControlChangedBlock: ((selectedRow: Int, value: Int) -> Void)?
  @IBOutlet weak var cellView: UIView!
  @IBOutlet weak var windowSegmentedControl: UISegmentedControl!

  func prepareForTableView(tableView: UITableView) {
    superTableView = tableView
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    dataPicker.delegate = self
    dataPicker.dataSource = self
    windowSegmentedControl.addTarget(self, action: "segmentedControlChanged:", forControlEvents: UIControlEvents.ValueChanged)
  }

  override func setSelected(selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
  }

  var title: String = "" {
    didSet {
      cellLabel.text = title
    }
  }

  func updateViewColorWhite() {
    cellView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
  }

  func updateViewColor() {
    cellView.backgroundColor = UIColor(red: 200, green: 200, blue: 200, alpha: 1)
  }

// MARK: - UIPickerViewDataSource
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return ActionType.count
  }

//  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//    return ActionType(rawValue: row)?.toString()
//  }
  
  func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
    let pickerLabel = UILabel()
    if let titleLabel = ActionType(rawValue: row)?.toString() {
      let attributedText = NSAttributedString(string: titleLabel, attributes: [NSFontAttributeName: UIFont(name: "HiraKakuProN-W3", size: 16.0)!])
      pickerLabel.attributedText = attributedText
    }
    
    return pickerLabel
  }

  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    pickerValue = row
    if let userDefinePickerChangedBlock = userDefinePickerChangedBlock {
      userDefinePickerChangedBlock(selectedRow: row)
    }
  }
  
  internal func segmentedControlChanged(segcon: UISegmentedControl) {
    print(segcon.selectedSegmentIndex)
    if let segmentedControlChangedBlock = segmentedControlChangedBlock {
      segmentedControlChangedBlock(selectedRow: 1, value: segcon.selectedSegmentIndex)
    }
  }
}
  