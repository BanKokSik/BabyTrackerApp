//
//  OnBoardingViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 26.06.23.
//

import UIKit


protocol OnBoardingViewControllerDelegate: AnyObject {
    func didTapNextButton()
}

class OnBoardingViewController: UIViewController {
    
    let imageView = UIImageView()
    let label = UILabel()
    var nextButton = UIButton(type: .system)
    
    weak var delegate: OnBoardingViewControllerDelegate?

    
    init(image: UIImage, textLabel: String) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
        label.text = textLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupStyles()
        layout()
    }
    
    @objc func nextButtonTapped() {
        guard let pageViewController = self.parent as? PageViewController else { return }
        pageViewController.didTapNextButton()
    }
}

extension OnBoardingViewController {
    
    func setupImageView() {
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
    }
    
    func setupLabel() {
        label.font = Fonts.gilroySemiBold18
        label.textColor = .black
        label.textAlignment = .center
    }
    
    func setupNextButton() {
        nextButton.setTitle("Далее", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = R.color.heliotrope()
        nextButton.layer.cornerRadius = 8
        nextButton.isUserInteractionEnabled = true
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    func setupStyles() {
        setupImageView()
        setupLabel()
        setupNextButton()
    }
    
    func layout() {
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(nextButton)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(555)
        }
        
        label.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton).inset(95)
            make.left.right.equalToSuperview().inset(91)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(60)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(70)
        }
    }
}
