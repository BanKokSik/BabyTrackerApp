//
//  CustomSwitch.swift
//  BabyTracker
//
//  Created by Мявкo on 23.07.23.
//

import UIKit
import SnapKit

class CustomSwitch: UIControl {
    
    // Public properties
    var thumbSize: CGSize = CGSize(width: 14, height: 14)
    var trackHeight: CGFloat = 6
    var trackWidth: CGFloat = 25
    
    var isOn: Bool = false {
        didSet {
            sendActions(for: .valueChanged)
            updateThumbPosition()
        }
    }
    
    // Private properties
    private let trackView = UIView()
    private let thumbView = UIView()
    
    private let offTrackColor = R.color.trackOff()
    private let offThumbColor = R.color.thumbOff()
    private let onTrackColor = R.color.trackOn()
    private let onThumbColor = R.color.thumbOn()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupGesture()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        trackView.layer.cornerRadius = trackHeight / 2
        addSubview(trackView)
        
        thumbView.layer.cornerRadius = thumbSize.height / 2
        addSubview(thumbView)
        
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        isOn = !isOn
    }
    
    // MARK: - Helper methods
    
    private func updateThumbPosition() {
        let xPosition = isOn ? trackView.frame.width - thumbSize.width : 0
        thumbView.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(xPosition)
        }
        
        trackView.backgroundColor = isOn ? onTrackColor : offTrackColor
        thumbView.backgroundColor = isOn ? onThumbColor : offThumbColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateThumbPosition()
    }
}
