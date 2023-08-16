//
//  FeedTableViewCell.swift
//  BabyTracker
//
//  Created by Мявкo on 10.08.23.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    static var reuseIdentifier = R.string.localizable.feedCellIdentifier()
    
    private lazy var borderView: BorderView = _borderView
    private lazy var borderTextLabel: UILabel = _borderTextLabel
    private lazy var timeLabel: UILabel = _timeLabel
    private lazy var iconImageView: UIImageView = _iconImageView
    private lazy var dataLabel: UILabel = _dataLabel
    private lazy var separator: BorderView = _separator
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupSubviewsOfEveryCell()
        applyConstraintsOfEveryCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createDashedBorder(width: CGFloat, color: UIColor) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = [2, 2] 
        return shapeLayer
    }
    
    private func setupSubviewsOfEveryCell() {
        addSubview(iconImageView)
    }
    
    private func applyConstraintsOfEveryCell() {
        iconImageView.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    func setEventsViews() {
        setupEventsSubviews()
        applyEventsConstraints()
    }
    
    private func setupEventsSubviews() {
        addSubview(borderView)
        borderView.addSubview(borderTextLabel)
        addSubview(timeLabel)
    }
    
    private func applyEventsConstraints() {
        borderView.snp.makeConstraints { make in
            make.width.equalTo(193)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(25)
        }
        
        borderTextLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(borderView.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupSeparator() {
        addSubview(separator)
        separator.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(27)
            make.top.equalTo(iconImageView.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(23)
        }
    }
    
    func setIcon(_ image: UIImage?) {
        iconImageView.image = image
    }
    
    func setTime(_ time: String) {
        timeLabel.text = time
    }
    
    func setData(_ text: String) {
        dataLabel.text = text
        layoutDataLabel()
    }
    
    func layoutDataLabel() {
        addSubview(dataLabel)
        dataLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(200)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
    }
}

extension FeedTableViewCell {
    
    var _iconImageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    var _borderView: BorderView {
        let border = BorderView()
        border.isActive = .inactive
        border.color = R.color.wildSand()
        border.layer.cornerRadius = 8
        border.clipsToBounds = true
        return border
    }
    
    var _borderTextLabel: UILabel {
        let label = UILabel()
        label.font = Fonts.gilroyMedium14
        label.text = "Lorem Ipsum"
        label.textColor = .lightGray
        return label
    }
    
    var _timeLabel: UILabel {
        let label = UILabel()
        label.font = Fonts.gilroyMedium14
        label.textColor = .lightGray
        return label
    }
    
    var _dataLabel: UILabel {
        let label = UILabel()
        label.font = Fonts.gilroyMedium14
        label.textColor = .lightGray
        return label
    }
    
    var _separator: BorderView {
        let border = BorderView()
        border.isActive = .active
        border.dashedColor = R.color.silver()
        border.lineWidth = 2
        border.dashPattern = [2, 4]
        return border
    }
}
