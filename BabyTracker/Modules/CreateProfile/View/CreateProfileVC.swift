//
//  CreateProfileVC.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 25.06.2023.
//

import UIKit
import SnapKit


protocol CreateProfileVCDelegate: AnyObject {}

class CreateProfileVC: UIViewController {
    
    weak var coordinator: Coordinator?
    private var createProfileCoordinator: CreateProfileCoordinator? { coordinator as? CreateProfileCoordinator }
    
    private lazy var createImageView: UIImageView = _createImageView
    
    private lazy var nameBorder: BorderView = _nameBorder
    private lazy var nameTextField: UITextField = _nameTextField
    private lazy var namePlaceholderLabel: UILabel = _namePlaceholderLabel
    
    private lazy var genderBorder: BorderView = _genderBorder
    private lazy var genderTextField: UITextField = _genderTextField
    private lazy var genderPlaceholderLabel: UILabel = _genderPlaceholderLabel
    
    private lazy var birthDateBorder: BorderView = _birthDateBorder
    private lazy var birthDateTextField: CustomTextField = _birthDateTextField
    private lazy var birthDatePicker: UIDatePicker = _birthDatePicker
    private lazy var birthDatePlaceholderLabel: UILabel = _birthDatePlaceholderLabel
    private lazy var toolbar: UIToolbar = _toolbar
    
    private lazy var nextButton: UIButton = _nextButton
    private lazy var userAgreement: UITextView = _userAgreement
    private lazy var stackView: UIStackView = _stackView
    private lazy var metricSystemLabel: UILabel = _metricSystemLabel
    private lazy var switcher: CustomSwitch = _switcher
    
    var blurView: UIVisualEffectView?
    
    var activeGender: Gender?
    weak var delegate: CreateProfileVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        addDelegate()
        initialaze()
    }
    
    private func addDelegate() {
        nameTextField.delegate = self
        genderTextField.delegate = self
        birthDateTextField.delegate = self
    }
    
    private func initialaze(){
        view.backgroundColor = .white
        
        setupConstraints()
        addTapedImageView()
        addDatePickerInTextField()
    }
    
    func makeBackgroundBlur() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.backgroundColor = UIColor.magenta.withAlphaComponent(0.06)
        blurView.frame = view.bounds
        view.addSubview(blurView)
        
        self.blurView = blurView
    }
 
    func showPopup() {
        createProfileCoordinator?.showPopup()
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        birthDateTextField.text = birthDateFormatter.string(from: sender.date)
    }
    
    @objc func doneButtonTapped() {
        birthDateTextField.resignFirstResponder()
    }
    
    
    // MARK: -> Select ImageView
    
    func alertImageView(){
        let alert = UIAlertController(title: nil, message: R.string.localizable.alertMessageToAddImage(), preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: R.string.localizable.alertActionCamera(), style: .default) { (action) in
            self.chooseImage(source: .camera)
        }
        
        let photoLibAction = UIAlertAction(title: R.string.localizable.alertActionGallery(), style: .default) { (action) in
            self.chooseImage(source: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: R.string.localizable.alertActionCancel(), style: .cancel, handler: nil)
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

        alertImageView()
    }
    
    func makeBorderActive(_ border: BorderView, isActive: Bool) {
        border.isActive = isActive ? .active : .inactive
        border.setNeedsDisplay()
    }
    
    func setValueToGenderTextField(value: String, gender: Gender?) {
        genderTextField.text = value
        activeGender = gender
    }
    
    @objc func nextButtonDidTap() {
        createProfileCoordinator?.didFinish()
    }
}


// MARK: -> Extension

extension CreateProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
}

extension CreateProfileVC: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            makeBorderActive(nameBorder, isActive: true)
        case 2:
            makeBorderActive(genderBorder, isActive: true)
            genderTextField.resignFirstResponder()
        case 3:
            makeBorderActive(birthDateBorder, isActive: true)
        default: break
        }
    }
    

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            birthDateTextField.resignFirstResponder()
            return true
        case 2:
            view.endEditing(true)
            showPopup()
            return true
        case 3:
            textField.text = birthDateFormatter.string(from: birthDatePicker.date)
            return true
        default: return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            makeBorderActive(nameBorder, isActive: false)
        case 2:
            makeBorderActive(genderBorder, isActive: false)
        case 3:
            makeBorderActive(birthDateBorder, isActive: false)
        default: break
        }
    }
}
// MARK: -> Add Subviews
extension CreateProfileVC {
    private func addViewOnSubview() {
        view.addSubview(createImageView)
        view.addSubview(userAgreement)
    }
}


extension CreateProfileVC {
    
    func setupConstraints() {
        layoutImage()
        layoutNameField()
        layoutGenderField()
        layoutBirthDateField()
        layoutMetricSwitcher()
        layoutButtonAndAgreement()
    }

    // MARK: -> Customization ImageView
    var _createImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = R.image.camera()
        return imageView
    }
    
    func layoutImage() {
        view.addSubview(createImageView)
        createImageView.snp.makeConstraints { make in
            make.height.equalTo(165)
            make.leading.trailing.equalToSuperview().inset(100)
            make.top.equalToSuperview().inset(125)
        }
    }
    
    // MARK: -> Customization NameTextField
    var _nameBorder: BorderView {
        let border = BorderView()
        border.isActive = .inactive
        border.lineWidth = 4
        border.dashPattern = [3, 4]
        border.layer.cornerRadius = 10
        border.clipsToBounds = true
        return border
    }
    
    var _nameTextField: UITextField {
        let textField = UITextField()
        textField.layer.borderColor = .none
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        let borderLayer = CAShapeLayer()
        textField.layer.addSublayer(borderLayer)
        textField.tintColor = .black
        textField.tag = 1
        return textField
    }
    
    var _namePlaceholderLabel: UILabel {
        let label = UILabel()
        label.text = R.string.localizable.namePlaceholder()
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = R.color.nobel()
        label.font = Fonts.gilroyRegular14
        return label
    }
    
    func layoutNameField() {
        nameBorder.addSubview(nameTextField)
        view.addSubview(nameBorder)
        view.addSubview(namePlaceholderLabel)
        
        nameBorder.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(69)
            make.top.equalTo(createImageView.snp.bottom).offset(25)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(0)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        namePlaceholderLabel.snp.makeConstraints { make in
            make.top.equalTo(nameBorder.snp.bottom).inset(17)
            make.leading.equalTo(nameBorder.snp.leading).inset(30)
            make.trailing.equalTo(nameBorder.snp.trailing).inset(200)
            make.height.equalTo(30)
        }
    }
    
    // MARK: -> Customization GenderTextField
    var _genderBorder: BorderView {
        let border = BorderView()
        border.isActive = .inactive
        border.lineWidth = 4
        border.dashPattern = [3, 4]
        border.layer.cornerRadius = 10
        border.clipsToBounds = true
        return border
    }
    
    var _genderTextField: UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.tintColor = .black
        textField.tag = 2
        return textField
    }
    
    var _genderPlaceholderLabel: UILabel {
        let label = UILabel()
        label.text = R.string.localizable.genderPlaceholder()
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = R.color.nobel()
        label.font = Fonts.gilroyRegular14
        return label
    }
    
    func layoutGenderField() {
        genderBorder.addSubview(genderTextField)
        view.addSubview(genderBorder)
        view.addSubview(genderPlaceholderLabel)
        
        genderBorder.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(69)
            make.top.equalTo(nameBorder.snp.bottom).offset(25)
        }
        
        genderTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(0)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        genderPlaceholderLabel.snp.makeConstraints { make in
            make.top.equalTo(genderBorder.snp.bottom).inset(17)
            make.leading.equalTo(genderBorder.snp.leading).inset(30)
            make.trailing.equalTo(genderBorder.snp.trailing).inset(255)
            make.height.equalTo(30)
        }
    }
    
    // MARK: -> Customization BirthDateTextField
    var _birthDateBorder: BorderView {
        let border = BorderView()
        border.isActive = .inactive
        border.lineWidth = 4
        border.dashPattern = [3, 4]
        border.layer.cornerRadius = 10
        border.clipsToBounds = true
        return border
    }
    
    var _birthDateTextField: CustomTextField {
        let textField = CustomTextField()
        textField.layer.borderColor = .none
        let borderLayer = CAShapeLayer()
        textField.layer.addSublayer(borderLayer)
        textField.tintColor = .clear
        textField.selectedTextRange = nil
        textField.tag = 3
        return textField
    }
    
    var _birthDatePicker: UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.setDate(Date(), animated: true)
        datePicker.minimumDate = birthDateFormatter.date(from: "01.01.1950")
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return datePicker
    }
    
    var birthDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.dateStyle = .long
        return dateFormatter
    }
    
    var _birthDatePlaceholderLabel: UILabel {
        let label = UILabel()
        label.text = R.string.localizable.birthDatePlaceholder()
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = R.color.nobel()
        label.font = Fonts.gilroyRegular14
        return label
    }
    
    var _toolbar: UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = .gray
        return toolbar
    }
    
    func addDatePickerInTextField() {
        birthDateTextField.inputView = birthDatePicker
        birthDateTextField.inputAccessoryView = toolbar
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        
        birthDatePicker.backgroundColor = .white.withAlphaComponent(0.8)
    }
    
    func layoutBirthDateField() {
        birthDateBorder.addSubview(birthDateTextField)
        view.addSubview(birthDateBorder)
        view.addSubview(birthDatePlaceholderLabel)
        
        birthDateBorder.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(69)
            make.top.equalTo(genderBorder.snp.bottom).offset(25)
        }
        
        birthDateTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        birthDatePlaceholderLabel.snp.makeConstraints { make in
            make.top.equalTo(birthDateBorder.snp.bottom).inset(17)
            make.leading.equalTo(birthDateBorder.snp.leading).inset(30)
            make.trailing.equalTo(birthDateBorder.snp.trailing).inset(178)
            make.height.equalTo(30)
        }
    }
    
    // MARK: -> Customization Metric system and Switcher
    
    var _stackView: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }
    
    var _metricSystemLabel: UILabel {
        let label = UILabel()
        label.text = R.string.localizable.metricSystemSwitcher()
        label.font = Fonts.gilroyRegular18
        return label
    }
    var _switcher: CustomSwitch {
        let switcher = CustomSwitch()
        switcher.isOn = true
        return switcher
    }
    
    func layoutMetricSwitcher() {
        stackView.addArrangedSubview(metricSystemLabel)
        stackView.addArrangedSubview(switcher)
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalTo(birthDateBorder.snp.bottom).offset(26)
        }
    }
    
    // MARK: -> Customization NextButton and UserAgreement
    
    var _nextButton: UIButton {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.nextButton(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Fonts.gilroyMedium18
        button.setBackgroundColor(R.color.heliotrope(), for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        return button
    }
    
    var _userAgreement: UITextView  {
        let text = UITextView()
        text.isSelectable = true
        let attributedString = NSMutableAttributedString(string: R.string.localizable.userAgreementTextView())
        let linkConditions = attributedString.setAsLink(textToFind: R.string.localizable.termsLabel(), linkURL: R.string.localizable.termsLink())
        if linkConditions{
            text.attributedText = attributedString
        }
        let linkPolitics = attributedString.setAsLink(textToFind: R.string.localizable.privacyPolicyLabel(), linkURL: R.string.localizable.privacyPolicyLink())
        if linkPolitics{
            text.attributedText = attributedString
        }
        text.attributedText = textWithSpaceBetweenLines(text: attributedString, space: 4)
        text.font = Fonts.gilroyRegular14
        text.textColor = R.color.nobel()
        text.isEditable = false
        return text
    }
    
    func textWithSpaceBetweenLines(text: NSMutableAttributedString, space: Double) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(space)
     
        text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.length))
        return text
    }
    
    func layoutButtonAndAgreement() {
        view.addSubview(nextButton)
        view.addSubview(userAgreement)
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(metricSystemLabel.snp.bottom).offset(20)
            make.height.equalTo(69)
        }
        
        userAgreement.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(nextButton.snp.bottom).offset(16)
            make.height.equalTo(63)
        }
    }
}
