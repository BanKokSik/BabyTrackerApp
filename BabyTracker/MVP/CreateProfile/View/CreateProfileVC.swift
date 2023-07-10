//
//  CreateProfileVC.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 25.06.2023.
//

import UIKit
import SnapKit

class CreateProfileVC: UIViewController{

    
    let gender = ["Genderqueer", "Male", "Female"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialaze()
    }
    
    private func initialaze(){
        
        view.backgroundColor = UIColor.white
        title = "Create profile"
        view.addSubview(createImageView)
        borderNameTF.addSubview(createNameTF)
        view.addSubview(borderNameTF)
        view.addSubview(placeholderLabel)
        view.addSubview(genderPicker)
        view.addSubview(datePicker)
        setupConstraints()
        genderPicker.dataSource = self
        genderPicker.delegate = self
        addTapedImageView()
        createNameTF.delegate = self
 
        
    }
    
    
    private let createImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.gray
        return image
    }()
    private let borderNameTF: BorderView = {
        let border = BorderView()
        border.isActive = false
        border.layer.cornerRadius = 10
        border.clipsToBounds = true
        return border
    }()
     lazy var createNameTF: UITextField = {
        let name = UITextField()
        name.layer.borderColor = .none
        name.textAlignment = .center
        name.clearButtonMode = .always
        let borderLayer = CAShapeLayer()
        name.layer.addSublayer(borderLayer)

        return name
    }()
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите имя"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
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
    

    private func  setupConstraints() {
        createImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(182)
            make.height.equalTo(156)
            make.top.equalToSuperview().inset(118)
        }
            
        borderNameTF.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalTo(313)
                make.height.equalTo(81)
                make.top.equalToSuperview().inset(300)
            }
        createNameTF.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview().inset(0)
            make.left.equalToSuperview().inset(0)
        }
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalTo(borderNameTF.snp.bottom).inset(17)
            make.left.equalToSuperview().offset(65)
            make.width.equalTo(100)
            make.height.equalTo(30)

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

  
 
    
//    MARK: -> Select ImageView
    
     func alertImageView(){
        let alert = UIAlertController(title: nil, message: "Выберите способ загрузги фотографии", preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.chooseImage(source: .camera)
        }
        let photoLibAction = UIAlertAction(title: "Photo", style: .default) { (action) in
            self.chooseImage(source: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cameraAction)
        alert.addAction(photoLibAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    private func chooseImage(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        createImageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        createImageView.contentMode = .scaleAspectFill
        createImageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    private func addTapedImageView() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapRecognizer:)))
        createImageView.isUserInteractionEnabled = true
        createImageView.addGestureRecognizer(tapRecognizer)
    }
    @objc func imageTapped(tapRecognizer: UITapGestureRecognizer){
//        let tappedImage = tapRecognizer.view as! UIImageView
        print("TappedImage")
        alertImageView()
        
    }
   
}

 
    
    
    
// MARK: -> Extension
    
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

extension CreateProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
}

extension CreateProfileVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        createNameTF.resignFirstResponder()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        borderNameTF.isActive = true
        borderNameTF.setNeedsDisplay()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        borderNameTF.isActive = false
        borderNameTF.setNeedsDisplay()
    }
    
}





