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
        addViewOnSubview()
        setupConstraints()
        addTapedImageView()
        addDelegate()
        
    }
    
    private func addDelegate() {
        genderPicker.dataSource = self
        genderPicker.delegate = self
        createNameTF.delegate = self
    }
    
    // MARK: -> Create elements
    
    private lazy var createImageView: UIImageView = _createImageView
    private lazy var borderNameTF: BorderView = _borderNameTF
    private lazy var createNameTF: UITextField = _createNameTF
    private lazy var placeholderLabel: UILabel = _placeholderLabel
    private lazy var genderPicker: UIPickerView = _genderPicker
    private lazy var datePicker: UIDatePicker = _datePicker
    private lazy var furtherButton: UIButton = _furtherButton
    private lazy var userAgreement: UITextView = _userAgreement
//    private lazy var stackView: UIStackView = _stackView
    private lazy var imageToStack: UIImageView = _imageToStack
    private lazy var labelToStack: UILabel = _labelToStack

    
    // MARK: -> Setup constraints
    private func  setupConstraints() {
        createImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(182)
            make.height.equalTo(156)
            make.top.equalToSuperview().inset(118)
        }
        
        borderNameTF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview().inset(29)
            make.height.equalTo(81)
            make.top.equalToSuperview().inset(300)
        }
        
        createNameTF.snp.makeConstraints { make in
            make.right.left.top.bottom.equalToSuperview().inset(0)
        }
        
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalTo(borderNameTF.snp.bottom).inset(17)
            make.left.equalToSuperview().offset(65)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        genderPicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview().inset(29)
            make.height.equalTo(81)
            make.top.equalTo(createNameTF).inset(100)
        }
        
        datePicker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview().inset(29)
            make.height.equalTo(81)
            make.top.equalTo(genderPicker).inset(100)
        }
        
        labelToStack.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.leading.equalToSuperview().inset(29)
            make.top.equalTo(datePicker).inset(100)
        }
        imageToStack.snp.makeConstraints { make in
            make.width.equalTo(28)
            make.height.equalTo(14)
            make.leading.equalTo(labelToStack).inset(200)
            make.top.equalTo(datePicker).inset(104)
        }
        
//        stackView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.directionalHorizontalEdges.equalToSuperview().inset(29)
//            make.top.equalTo(datePicker).inset(100)
//            make.height.equalTo(22)
//        }
        
        furtherButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview().inset(29)
            make.top.equalTo(labelToStack).inset(30)
            make.height.equalTo(69)
        }
        
        userAgreement.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview().inset(29)
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(63)
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
        print("TappedImage")
        alertImageView()
    }
    
}


// MARK: -> Extension

extension CreateProfileVC {
    var _createImageView: UIImageView {
        let image = UIImageView()
        image.image = UIImage(named: "PhotoImage")
        image.layer.cornerRadius = 10
        return image
    }
    var _borderNameTF: BorderView {
        let border = BorderView()
        border.isActive = false
        border.layer.cornerRadius = 10
        border.clipsToBounds = true
        return border
    }
   var _createNameTF: UITextField  {
        let name = UITextField()
        name.layer.borderColor = .none
        name.textAlignment = .center
        name.clearButtonMode = .always
        let borderLayer = CAShapeLayer()
        name.layer.addSublayer(borderLayer)
        
        return name
    }
   var _placeholderLabel: UILabel  {
        let label = UILabel()
        label.text = "Введите имя"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }
    
    var _genderPicker: UIPickerView  {
        let gender = UIPickerView()
        gender.layer.borderWidth = 2
        gender.layer.borderColor = CGColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        gender.layer.cornerRadius = 10
        return gender
    }
    var _datePicker: UIDatePicker {
        let date = UIDatePicker()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy"
        date.datePickerMode = .date
        date.setDate(Date(), animated: true)
        date.minimumDate = dateFormater.date(from: "01.01.1950")
        date.maximumDate = Date()
        
        return date
    }
    var _furtherButton: UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 207, green: 104, blue: 255)
        button.layer.cornerRadius = 10
        button.setTitle("Далее", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }
    
    var _userAgreement: UITextView  {
        let text = UITextView()
        
        text.isSelectable = true
        let attributedString = NSMutableAttributedString(string: """
Нажимая «Далее», вы подтверждаете, что прочитали и приняли наши Условия и Политику конфиденциальности.
""")
        let linkConditions = attributedString.setAsLink(textToFind: "Условия", linkURL: "https://mykiddy.online/eu.pdf")
        if linkConditions{
            text.attributedText = attributedString
        }
        let linkPolitics = attributedString.setAsLink(textToFind: "Политику конфиденциальности", linkURL: "https://mykiddy.online/pp.pdf")
        if linkPolitics{
            text.attributedText = attributedString
        }
        text.font = Fonts.gilroyRegular14
        text.textColor = UIColor.rgb(red: 180, green: 180, blue: 180)
        text.isEditable = false
        return text
    }
    
    var _labelToStack: UILabel{
        let label = UILabel()
        label.text = "Метрическая система"
        label.font = Fonts.gilroyRegular18
        return label
    }
    var _imageToStack: UIImageView{
        let image = UIImageView()
        image.image = UIImage(named: "slide")
        return image
    }
    
//    var _stackView: UIStackView {
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.alignment = .leading
//        stack.distribution = .fillEqually
//        stack.addArrangedSubview(labelToStack)
//        stack.addArrangedSubview(imageToStack)
//
//        return stack
//    }
}
extension CreateProfileVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        gender.count
    }
    
    
}
// MARK: -> Add Delegate
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
// MARK: -> Add Subviews
extension CreateProfileVC {
    private func addViewOnSubview() {
        view.addSubview(createImageView)
        borderNameTF.addSubview(createNameTF)
        view.addSubview(borderNameTF)
        view.addSubview(placeholderLabel)
        view.addSubview(genderPicker)
        view.addSubview(datePicker)
        view.addSubview(labelToStack)
        view.addSubview(imageToStack)
        view.addSubview(furtherButton)
        view.addSubview(userAgreement)
        

    }
}





