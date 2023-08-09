//
//  TableViewCell.swift
//  BabyTracker
//
//  Created by Мявкo on 7.08.23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let reuseIdentifier = R.string.localizable.tableCellIdentifier()
    
    private lazy var iconImageView: UIImageView = _iconImageView
    private lazy var addButton: UIButton = _addButton
    
    private lazy var stackView: UIStackView = _stackView
    private lazy var eventLabel: UILabel = _eventLabel
    private lazy var subtitleLabel: UILabel = _subtitleLabel
    
    var currentCell = 0
    
    private var isEventAdded: Bool = false {
        didSet {
            if isEventAdded {
                addStackView()
                addButton.snp.removeConstraints()
                addButton.snp.makeConstraints { make in
                    make.leading.equalTo(stackView).offset(180)
                    make.centerY.equalToSuperview()
                    make.trailing.equalToSuperview().inset(10)
                }
            } else {
                addButton.snp.removeConstraints()
                addButton.snp.makeConstraints { make in
                    make.leading.equalTo(iconImageView).offset(30)
                    make.centerY.equalToSuperview()
                    make.trailing.equalToSuperview().inset(200)
                }
                stackView.removeFromSuperview()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupSubviews() {
        addSubview(iconImageView)
        addSubview(addButton)
    }
    
    private func applyConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(33)
            make.width.equalTo(23)
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView).offset(30)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(200)
        }
    }
    
    func addStackView() {
        if currentCell != 0 {
            stackView.addArrangedSubview(eventLabel)
            stackView.addArrangedSubview(subtitleLabel)
        } else {
            stackView.addArrangedSubview(eventLabel)
        }
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView).offset(40)
            make.centerY.equalToSuperview()
        }
    }
    
    func toggleExpansion() {
        isEventAdded.toggle()
    }
    
    func setIcons(_ image: UIImage?) {
        iconImageView.image = image
    }
    
    func addEvent(title: String, subtitle: String?) {
        eventLabel.text = title
        subtitleLabel.text = subtitle
    }
}

extension TableViewCell {
    
    var _iconImageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    var _stackView: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }
    
    var _eventLabel: UILabel {
        let label = UILabel()
        label.font = Fonts.gilroyMedium14
        label.textColor = .black
        return label
    }
    
    var _subtitleLabel: UILabel {
        let label = UILabel()
        label.font = Fonts.gilroyMedium14
        label.textColor = R.color.silver()
        return label
    }
    
    var _addButton: UIButton {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.addButton(), for: .normal)
        button.setTitleColor(R.color.silver(), for: .normal)
        
        let borderView = BorderView()
        borderView.isActive = .active
        borderView.dashedColor = R.color.silver()
        borderView.lineWidth = 2
        borderView.dashPattern = [2, 4]
        button.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo((button.titleLabel?.snp.bottom)!).offset(6)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        return button
   }
}
