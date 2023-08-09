//
//  CustomCalendarCellCollectionViewCell.swift
//  BabyTracker
//
//  Created by Мявкo on 4.08.23.
//

import UIKit
import FSCalendar

class CustomCalendarCell: FSCalendarCell {
    
    static let reuseIdentifier = R.string.localizable.calendarCellIdentifier()
    
    private var eventLayers: [CALayer:Int] = [:]
    private lazy var eventStackView: UIStackView = _eventStackView
    private var containerView: UIView!
    private var isTodayConstraints: [Bool : Int] = [true : 5, false: 12]
     
    private func setupEventStackView(isToday: Bool) {
        contentView.addSubview(eventStackView)
        eventStackView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).inset(isTodayConstraints[isToday]!)
            make.centerY.equalToSuperview().offset(-3.5)
        }
    }
    
    func clearEventDots() {
        for subview in eventStackView.arrangedSubviews {
            eventStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
    
    func layoutDot(dot: UIView) {
        eventStackView.addArrangedSubview(dot)
        dot.snp.makeConstraints { make in
            make.height.width.equalTo(4)
        }
    }
    
    func createDot(event: EventModel) {
        guard let eventCount = Event.eventDict[event.event!], eventCount <= 1 else { return }
        
        let eventDotView = UIView()
        eventDotView.layer.cornerRadius = 3
        
        eventDotView.backgroundColor = event.event?.color
        layoutDot(dot: eventDotView)
    }
    
    func addEventDots(isToday: Bool, events: [EventModel], areAlreadyExist: Bool) {
        setupEventStackView(isToday: isToday)
        
        guard eventStackView.arrangedSubviews.count < Event.events.count else { return }
        
        if areAlreadyExist {
            for event in events {
                createDot(event: event)
            }
        } else {
            createDot(event: events[events.count - 1])
        }
    }
}

extension CustomCalendarCell {
    var _eventStackView: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }
}
