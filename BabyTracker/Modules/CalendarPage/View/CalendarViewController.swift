//
//  CalendarViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 3.08.23.
//

import UIKit
import FSCalendar

class CalendarViewController: BaseViewController {
    
    weak var coordinator: Coordinator?
    private var calendarCoordinator: CalendarCoordinator? { coordinator as? CalendarCoordinator }
    
    var presenter: CalendarPresenter?
    private lazy var calendar: FSCalendar! = _calendar
    
    private lazy var calendarIcon: UIImageView = _calendarIcon
    private lazy var monthLabel: UILabel = _monthLabel
    private lazy var yearLabel: UILabel = _yearLabel
    
    private lazy var separatorView: UIView = _separatorView
    private lazy var tableView: UITableView = _tableView
    
    let events = EventModel.events
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CalendarPresenter()
        
        setupMonthAndYear()
        setupSubviews()
        applyConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(calendarIcon)
        view.addSubview(monthLabel)
        view.addSubview(yearLabel)
        view.addSubview(calendar)
        view.addSubview(separatorView)
        view.addSubview(tableView)
    }
    
    private func applyConstraints() {
        calendarIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.height.equalTo(33)
            make.width.equalTo(35)
            make.centerX.equalToSuperview()
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalTo(calendarIcon.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(monthLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        calendar.snp.makeConstraints { (make) in
            make.height.equalTo(220)
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(yearLabel.snp.bottom).offset(22)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(35)
            make.height.equalTo(1.5)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(180)
        }
    }
    
    func setupMonthAndYear() {
        let monthName = presenter?.getMonthValue(from: calendar)
        monthLabel.text = monthName
        
        let yearValue = presenter!.getYearValue(from: calendar)
        yearLabel.text = "\(yearValue)"
    }
}

extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        calendar.appearance.todayColor = .clear
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        setupMonthAndYear()
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: CustomCalendarCell.reuseIdentifier, for: date, at: position) as! CustomCalendarCell
        
        cell.clearEventDots()
        
        let dateData = presenter!.getDateData(cellFor: date)
        if let events = events[dateData.date] {
            cell.addEventDots(isToday: dateData.isToday, events: events, areAlreadyExist: true)
        }
        return cell
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CalendarTableViewCell.reuseIdentifier, for: indexPath) as! CalendarTableViewCell

        let event = Event.events[indexPath.row]
        cell.setIcons(event.icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter!.getHeightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        var eventsArray = presenter!.initEventsArray(date: selectedDate, indexPath: indexPath)
        
        let newEvent = presenter!.createEventForIndexPath(indexPath)
        eventsArray.append(newEvent)
        
        presenter?.updateEventModelData(date: selectedDate, events: eventsArray)
        presenter?.updateTableViewCell(tableView, at: indexPath, with: newEvent)
        presenter?.updateCalendarCell(calendar, for: selectedDate, with: eventsArray)
    }
}

private extension CalendarViewController {
    
    var _calendarIcon: UIImageView {
        let imageView = UIImageView()
        imageView.image = R.image.calendar()
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        return imageView
    }
    
    var _monthLabel: UILabel {
        let label = UILabel()
        label.font = Fonts.gilroyMedium32
        label.textColor = .black
        return label
    }
    
    var _yearLabel: UILabel {
        let label = UILabel()
        label.font = Fonts.gilroyMedium18
        label.textColor = .lightGray
        return label
    }
    
    var _calendar: FSCalendar {
        let calendar = FSCalendar()
        calendar.register(CustomCalendarCell.self, forCellReuseIdentifier: CustomCalendarCell.reuseIdentifier)
        calendar.dataSource = self
        calendar.delegate = self
        calendar.appearance.selectionColor = R.color.wildSand()
        calendar.appearance.titleSelectionColor = .black
        calendar.appearance.todayColor = R.color.wildSand()
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.borderRadius = 0.3
        calendar.headerHeight = 0
        calendar.firstWeekday = 2         // from Monday
        calendar.placeholderType = .none  // hide days of other months
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase // "Пн" -> "П"
        calendar.appearance.weekdayTextColor = .lightGray
        calendar.appearance.weekdayFont = Fonts.gilroyMedium14
        calendar.appearance.titleFont = Fonts.gilroyMedium14
        return calendar
    }
    
    var _separatorView: UIView {
        let separator = UIView()
        separator.backgroundColor = R.color.wildSand()
        return separator
    }
    
    var _tableView: UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: CalendarTableViewCell.reuseIdentifier)
        return tableView
    }
}
