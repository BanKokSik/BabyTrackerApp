//
//  CreateProfileVC.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 25.06.2023.
//

import UIKit
import SnapKit

class CreateProfileVC: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialaze()
    }
 
    
    let gender = ["Genderqueer", "Male", "Female"]
    
    
    private func initialaze(){
        
        view.backgroundColor = UIColor.white
        title = "Create profile"
        view.addSubview(createImageView)
        view.addSubview(createNameTF)
        view.addSubview(genderPicker)
        view.addSubview(datePicker)
        setupConstraints()
        genderPicker.dataSource = self
        genderPicker.delegate = self
        
    }
    
    private func  setupConstraints() {
        createImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(182)
            make.height.equalTo(156)
            make.top.equalToSuperview().inset(118)
        }
            createNameTF.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalTo(313)
                make.height.equalTo(81)
                make.top.equalToSuperview().inset(300)
            }
        
        genderPicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(313)
            make.height.equalTo(81)
            make.top.equalTo(createNameTF).inset(100)
        }
        datePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(313)
            make.height.equalTo(81)
            make.top.equalTo(genderPicker).inset(100)
        }
        
    }
    
    
    
    private let createImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.black
        return image
    }()
    private let createNameTF: UITextField = {
        let name = UITextField()
        name.layer.borderWidth = 2
        name.layer.borderColor = CGColor.init(red: 207/255, green: 105/255, blue: 255/255, alpha: 1)
        name.layer.cornerRadius = 10
        name.placeholder = "Введите имя"
        name.textAlignment = .center
        name.clearButtonMode = .always
        return name
    }()
    private let genderPicker: UIPickerView = {
        let gender = UIPickerView()
        gender.layer.borderWidth = 2
        gender.layer.borderColor = CGColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        gender.layer.cornerRadius = 10
        return gender
    }()
    private let datePicker: UIDatePicker = {
        let date = UIDatePicker()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy"
        date.datePickerMode = .date
        date.setDate(Date(), animated: true)
        date.minimumDate = dateFormater.date(from: "01.01.1950")
        date.maximumDate = Date()
        
        return date
    }()
    

    
}
    
    
    
    
    
    extension CreateProfileVC: UIPickerViewDataSource {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            gender.count
        }


    }
    extension CreateProfileVC: UIPickerViewDelegate{
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            gender[row]
        }
    }



