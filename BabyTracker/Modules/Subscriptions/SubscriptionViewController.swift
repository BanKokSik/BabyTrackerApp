//
//  SubscriptionViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 16.07.23.
//

import UIKit

class SubscriptionViewController: UIViewController {
    
    private lazy var containerView: UIView = _containerView
    private lazy var imageView: UIImageView = _imageView
    private lazy var advantagesTextView: UITextView = _advantagesTextView
    
    private lazy var nextButton: UIButton = _nextButton
    private lazy var descriptionTextView: UITextView = _descriptionTextView
    
    private lazy var popularView: UIView = _popularView
    
    private lazy var subscriptionsViews: [UICustomView] = [
        yearSubscriptionView,
        monthSubscriptionView,
        foreverSubscriptionView
    ]
    
    private lazy var selectorsTap: [Selector] = [
        #selector(yearSubscriptionIsTapped),
        #selector(monthSubscriptionIsTapped),
        #selector(foreverSubscriptionIsTapped)
    ]
    
    //private lazy var stackView: UIStackView = _stackView
    
    var period: Subscription = .year

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        yearSubscriptionView.isActive = .active
        
        setupIconsAndText()
        setupViews()
        configureTapGestureBoth()
    }
    
    func configureTapGestureBoth() {
        for i in 0...subscriptionsViews.count - 1 {
            configureTapGesture(for: subscriptionsViews[i], action: selectorsTap[i])
        }
    }
    
    func configureTapGesture(for view: UICustomView, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    @objc private func yearSubscriptionIsTapped() {
        toggleViewActiveState(yearSubscriptionView)
        period = .year
        changeDescription(for: period)
    }
    
    @objc private func monthSubscriptionIsTapped() {
        toggleViewActiveState(monthSubscriptionView)
        period = .month
        changeDescription(for: period)
    }
    
    @objc private func foreverSubscriptionIsTapped() {
        toggleViewActiveState(foreverSubscriptionView)
        period = .forever
        changeDescription(for: period)
    }
    
    @objc private func buttonNextIsTapped() {
    }
    
    func toggleViewActiveState(_ viewIsTapped: UICustomView) {
        
        guard viewIsTapped.isActive != .active else { return }
        
        for view in subscriptionsViews {
            if view != viewIsTapped {
                view.isActive = .inactive
            } else {
                view.isActive = .active
            }
            view.setNeedsDisplay()
        }
    }
    
    lazy var yearSubscriptionView: UICustomView = {
        let view = UICustomView()
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.lineWidth = 4
        view.dashPattern = [3, 4]
        return view
    }()
    
    lazy var monthSubscriptionView: UICustomView = {
        let view = UICustomView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.lineWidth = 4
        view.dashPattern = [3, 4]
        return view
    }()
    
    lazy var foreverSubscriptionView: UICustomView = {
        let view = UICustomView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.lineWidth = 4
        view.dashPattern = [3, 4]
        return view
    }()
    
    lazy var popularLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.popularPlaceholderLabel()
        label.font = Fonts.gilroySemiBold11
        label.textAlignment = .center
        return label
    }()
    
    func textWithSpaceBetweenLines(text: String, space: Double) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
 
        let attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return attributedText
    }
}

enum Subscription {
    case year
    case month
    case forever
}

extension SubscriptionViewController {
    
    var _containerView: UIView {
        let view = UIView()
        return view
    }
    
    var _advantagesTextView: UITextView {
        let textView = UITextView()
        textView.attributedText = textWithSpaceBetweenLines(text: R.string.localizable.advantagesOfSubscriptionsTextView(), space: -0.7)
        textView.font = Fonts.gilroyRegular18
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }

    var _imageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = R.image.icons()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func setupIconsAndText() {
        containerView.addSubview(imageView)
        containerView.addSubview(advantagesTextView)
        view.addSubview(containerView)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(45)
            make.leading.equalToSuperview()
            make.top.equalToSuperview().inset(25)
            make.height.equalTo(185)
        }
        
        advantagesTextView.snp.makeConstraints { make in
            make.leading.equalTo(imageView).inset(40)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.leading.trailing.equalToSuperview().offset(30)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(115)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(69)
        }
        
        view.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(25)
            make.leading.trailing.equalToSuperview().inset(33)
            make.height.equalTo(80)
        }
    }
    
//    var _stackView: UIStackView {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.distribution = .fill
//        stackView.alignment = .leading
//        return stackView
//    }
    var _popularView: UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = R.color.mySin()?.cgColor
        view.layer.borderWidth = 1.5
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }
    
    var titleSubscriptionLabel: UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Fonts.gilroyMedium18
        return label
    }
    
    var priceSubscriptionLabel: UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Fonts.gilroyMedium14
        label.textColor = R.color.nobel()
        return label
    }
    
    func setupView(_ subscriptionView: UICustomView, period: Subscription) {
        let title = titleSubscriptionLabel
        let price = priceSubscriptionLabel
        
        switch period {
        case .year:
            title.text = R.string.localizable.subscriptionForAYearLabel()
            price.text = R.string.localizable.subscriptionForAYearPriceLabel()
        case .month:
            title.text = R.string.localizable.subscriptionForAMonthLabel()
            price.text = R.string.localizable.subscriptionForAMonthPriceLabel()
        case .forever:
            title.text = R.string.localizable.subscriptionForeverLabel()
            price.attributedText = strikethroughText
        }
        
        subscriptionView.addSubview(title)
        subscriptionView.addSubview(price)
        view.addSubview(subscriptionView)
        
        title.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(25)
        }
        
        price.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(35)
            make.top.equalTo(title).inset(28)
        }
    }
    
    var strikethroughText: NSMutableAttributedString {
        let text = R.string.localizable.subscriptionForeverPriceLabel()
        let attributedText = NSMutableAttributedString(string: text)

        let range = (text as NSString).range(of: "4980р")
        attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        return attributedText
    }
    
    func setupViews() {
        setupView(yearSubscriptionView, period: .year)
        yearSubscriptionView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(250)
            make.centerX.equalToSuperview()
            make.width.equalTo(315)
            make.height.equalTo(90)
        }
        
        popularView.addSubview(popularLabel)
        popularLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(popularView)
        popularView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(containerView).offset(235)
            make.leading.equalToSuperview().inset(245)
            make.trailing.equalToSuperview().inset(35)
        }

        setupView(monthSubscriptionView, period: .month)
        monthSubscriptionView.snp.makeConstraints { make in
            make.top.equalTo(yearSubscriptionView).offset(110)
            make.centerX.equalToSuperview()
            make.width.equalTo(315)
            make.height.equalTo(90)
        }
        
        setupView(foreverSubscriptionView, period: .forever)
        foreverSubscriptionView.snp.makeConstraints { make in
            make.top.equalTo(monthSubscriptionView).offset(110)
            make.centerX.equalToSuperview()
            make.width.equalTo(315)
            make.height.equalTo(90)
        }
    }
    
    var _nextButton: UIButton {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.nextButton(), for: .normal)
        button.titleLabel?.font = Fonts.gilroyMedium18
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundColor(R.color.heliotrope(), for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonNextIsTapped), for: .touchUpInside)
        return button
    }
    
    var _descriptionTextView: UITextView {
        let textView = UITextView()
        textView.attributedText = textWithSpaceBetweenLines(text: R.string.localizable.describeSubscriptionForAYearTextView(), space: 5)
        textView.textColor = R.color.nobel()
        textView.font = Fonts.gilroyRegular14
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }
    
    func changeDescription(for period: Subscription) {
        switch period {
        case .year:
            descriptionTextView.text = R.string.localizable.describeSubscriptionForAYearTextView()
        case .month:
            descriptionTextView.text = R.string.localizable.describeSubscriptionForAMonthTextView()
        case .forever:
            descriptionTextView.text = R.string.localizable.describeSubscriptionForeverTextView()
        }
    }
}
