//
//  SubscriptionViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 16.07.23.
//

import UIKit

enum Subscription {
    case year
    case month
    case forever
}

protocol SubscriptionViewControllerDelegate: AnyObject {}

class SubscriptionViewController: BaseViewController {
    
    weak var delegate: SubscriptionViewControllerDelegate?
    
    weak var coordinator: Coordinator?
    private var subscriptionCoordinator: SubscriptionCoordinator? { coordinator as? SubscriptionCoordinator }

    private lazy var restoreButton: UIButton = _restoreButton
    private lazy var closeButton: UIButton = _closeButton
    
    private lazy var containerView: UIView = _containerView
    private lazy var imageView: UIImageView = _imageView
    private lazy var advantagesTextView: UITextView = _advantagesTextView
    
    private lazy var yearSubscriptionView: BorderView = _yearSubscriptionView
    private lazy var monthSubscriptionView: BorderView = _monthSubscriptionView
    private lazy var foreverSubscriptionView: BorderView = _foreverSubscriptionView
    private lazy var popularView: UIView = _popularView
    private lazy var popularLabel: UILabel = _popularLabel
    
    private lazy var subscriptionsViews: [BorderView] = [
        yearSubscriptionView,
        monthSubscriptionView,
        foreverSubscriptionView
    ]
    
    private lazy var selectorsTap: [Selector] = [
        #selector(yearSubscriptionIsTapped),
        #selector(monthSubscriptionIsTapped),
        #selector(foreverSubscriptionIsTapped)
    ]
    
    private lazy var nextButton: UIButton = _nextButton
    private lazy var descriptionTextView: UITextView = _descriptionTextView

    private var period: Subscription = .year

    override func viewDidLoad() {
        super.viewDidLoad()
        yearSubscriptionView.isActive = .active
        
        configureTapGestureViews()
        setupNavigationBar()
        
        setupSubviews()
        applyConstraints()
    }
    
    private func setupSubviews() {
        containerView.addSubview(imageView)
        containerView.addSubview(advantagesTextView)
        view.addSubview(containerView)
        
        setupSubscription(yearSubscriptionView, period: .year)
        setupSubscription(monthSubscriptionView, period: .month)
        setupSubscription(foreverSubscriptionView, period: .forever)
        
        popularView.addSubview(popularLabel)
        view.addSubview(popularView)
        
        view.addSubview(nextButton)
        view.addSubview(descriptionTextView)
    }
    
    private func applyConstraints() {
        
        // MARK: - Icons and TextView
        
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
            make.top.equalToSuperview().inset(85)
            make.leading.trailing.equalToSuperview().offset(30)
        }
        
        // MARK: - Subscriptions
        
        yearSubscriptionView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(250)
            make.centerX.equalToSuperview()
            make.width.equalTo(315)
            make.height.equalTo(90)
        }
        
        popularLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        popularView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(containerView).offset(235)
            make.leading.equalToSuperview().inset(245)
            make.trailing.equalToSuperview().inset(35)
        }

        monthSubscriptionView.snp.makeConstraints { make in
            make.top.equalTo(yearSubscriptionView).offset(110)
            make.centerX.equalToSuperview()
            make.width.equalTo(315)
            make.height.equalTo(90)
        }
        
        foreverSubscriptionView.snp.makeConstraints { make in
            make.top.equalTo(monthSubscriptionView).offset(110)
            make.centerX.equalToSuperview()
            make.width.equalTo(315)
            make.height.equalTo(90)
        }
        
        // MARK: - Button "Next"
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(115)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(69)
        }
        
        // MARK: - TextView "Description"
        
        descriptionTextView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(25)
            make.leading.trailing.equalToSuperview().inset(33)
            make.height.equalTo(80)
        }
    }
    
    private func setupSubscription(_ subscriptionView: BorderView, period: Subscription) {
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
    
    private func configureTapGestureViews() {
        for i in 0...subscriptionsViews.count - 1 {
            configureTapGesture(for: subscriptionsViews[i], action: selectorsTap[i])
        }
    }
    
    private func configureTapGesture(for view: BorderView, action: Selector) {
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
        subscriptionCoordinator?.didFinish()
    }
    
    private func toggleViewActiveState(_ viewIsTapped: BorderView) {
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
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: restoreButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
    }
    
    @objc private func restoreButtonTapped() {
       print("Восстановить")
   }

    @objc private func closeButtonTapped() {
        subscriptionCoordinator?.didFinish()
    }
    
    private func changeDescription(for period: Subscription) {
        switch period {
        case .year:
            descriptionTextView.text = R.string.localizable.describeSubscriptionForAYearTextView()
        case .month:
            descriptionTextView.text = R.string.localizable.describeSubscriptionForAMonthTextView()
        case .forever:
            descriptionTextView.text = R.string.localizable.describeSubscriptionForeverTextView()
        }
    }
    
    private var strikethroughText: NSMutableAttributedString {
        let text = R.string.localizable.subscriptionForeverPriceLabel()
        let attributedText = NSMutableAttributedString(string: text)

        let range = (text as NSString).range(of: "4980р")
        attributedText.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        return attributedText
    }
}

private extension SubscriptionViewController {
    
    // MARK: - Navigation Bar
    
    var _restoreButton: UIButton {
        let restoreAttributes: [NSAttributedString.Key: Any] = [.font: Fonts.gilroyRegular14!]
        let restoreAttributedString = NSAttributedString(string: R.string.localizable.restoreButton(), attributes: restoreAttributes)
        
        let restoreButton = UIButton(type: .system)
        restoreButton.setAttributedTitle(restoreAttributedString, for: .normal)
        restoreButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
        restoreButton.tintColor = .lightGray
        
        var restoreConfig = UIButton.Configuration.plain()
        restoreConfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0)
        restoreButton.configuration = restoreConfig
        return restoreButton
    }
    
    var _closeButton: UIButton {
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(R.image.close(), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.tintColor = .lightGray
        
        var closeConfig = UIButton.Configuration.plain()
        closeConfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 25)
        closeButton.configuration = closeConfig
        return closeButton
    }
    
    // MARK: - Advantages of subscription (Icons and TextView)
    
    var _containerView: UIView {
        let view = UIView()
        return view
    }
    
    var _advantagesTextView: UITextView {
        let textView = UITextView()
        textView.attributedText = textView.textWithSpaceBetweenLines(text: R.string.localizable.advantagesOfSubscriptionsTextView(), space: -0.7)
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
    
    // MARK: - Subscriptions
    
    var _yearSubscriptionView: BorderView {
        let view = BorderView()
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.lineWidth = 4
        view.dashPattern = [3, 4]
        return view
    }
    
    var _monthSubscriptionView: BorderView {
        let view = BorderView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.lineWidth = 4
        view.dashPattern = [3, 4]
        return view
    }
    
    var _foreverSubscriptionView: BorderView {
        let view = BorderView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.lineWidth = 4
        view.dashPattern = [3, 4]
        return view
    }

    var _popularView: UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = R.color.mySin()?.cgColor
        view.layer.borderWidth = 1.5
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }
    
    var _popularLabel: UILabel {
        let label = UILabel()
        label.text = R.string.localizable.popularPlaceholderLabel()
        label.font = Fonts.gilroySemiBold11
        label.textAlignment = .center
        return label
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
    
    // MARK: - Next Button and Description of Subscription
    
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
        textView.attributedText = textView.textWithSpaceBetweenLines(text: R.string.localizable.describeSubscriptionForAYearTextView(), space: 5)
        textView.textColor = R.color.nobel()
        textView.font = Fonts.gilroyRegular14
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }
}
