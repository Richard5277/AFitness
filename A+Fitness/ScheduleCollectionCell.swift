//
//  ScheduleCollectionCell.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-20.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit
import iMaster

class ScheduleCollectionCell: BaseCollectionVewCell,UIPickerViewDelegate, UIPickerViewDataSource {

    let numbers = ["1","2","3","4","5","6","7","8","9","10","11"]
    
    let exerciseLaybel: UILabel = {
        let label = UILabel()
        label.text = "Category Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = myColor.mainBlack
        return label
    }()
    
    let PickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    override func setUpView() {
        PickerView.delegate = self
        PickerView.dataSource = self
        PickerView.backgroundColor = myColor.lightYellow
        PickerView.showsSelectionIndicator = true
        addCustomView(exerciseLaybel)
        exerciseLaybel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
        
        addCustomView(PickerView)
        PickerView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-32)
            make.width.equalTo(36)
            make.height.equalTo(100)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 11
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print(numbers[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numbers[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        guard let label = view as? UILabel else {
            preconditionFailure ("Expected a Label")
        }
        
        label.font = UIFont(name: "Times New Roman", size: 1.0)
        label.text = numbers[row]
        return label
    }
    
}





