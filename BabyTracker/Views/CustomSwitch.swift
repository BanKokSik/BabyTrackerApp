//
//  CustomSwitch.swift
//  BabyTracker
//
//  Created by Мявкo on 23.07.23.
//

import UIKit
import SnapKit

class CustomSwitch: UIControl {
    
    var isOn: Bool = false {
        didSet {
            sendActions(for: .valueChanged)
            updateThumbPosition()
        }
    }
    
    // Private properties
    private lazy var trackView: UIView = _trackView
    private lazy var thumbView: UIView = _thumbView
    
    private let thumbSize: CGSize = CGSize(width: 14, height: 14)
    private let trackHeight: CGFloat = 6
    private let trackWidth: CGFloat = 25
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        applyConstraints()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateThumbPosition()
    }
        
    // MARK: - Setup
    
    private func setupSubviews() {
        addSubview(trackView)
        addSubview(thumbView)
    }
    
    private func applyConstraints() {
        
        trackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(trackWidth)
            make.height.equalTo(trackHeight)
        }
        
        thumbView.snp.makeConstraints { make in
            make.width.equalTo(thumbSize.width)
            make.height.equalTo(thumbSize.height)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        updateThumbPosition()
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    
    @objc func handleTap() {
        isOn = !isOn
    }
    
    // MARK: - Helper methods
    
    private func updateThumbPosition() {
        let xPosition = isOn ? trackView.frame.width - thumbSize.width : 0
        thumbView.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(xPosition)
        }
        
        trackView.backgroundColor = isOn ? R.color.trackOn() : R.color.trackOff()
        thumbView.backgroundColor = isOn ? R.color.thumbOn() : R.color.thumbOff()
    }
}

private extension CustomSwitch {
    
    var _trackView: UIView {
        let result = UIView()
        result.layer.cornerRadius = trackHeight / 2
        return result
    }
    
    var _thumbView: UIView {
        let result = UIView()
        result.layer.cornerRadius = thumbSize.height / 2
        return result
    }
}
