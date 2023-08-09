//
//  CalendarViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 3.08.23.
//

import UIKit
import FSCalendar

class CalendarViewController: BaseViewController {
    
    private lazy var calendar: FSCalendar! = _calendar
    
    private lazy var dateFormatter: DateFormatter = _dateFormatter
    private lazy var calendarIcon: UIImageView = _calendarIcon
    private lazy var monthLabel: UILabel = _monthLabel
    private lazy var yearLabel: UILabel = _yearLabel
    
    private lazy var separatorView: UIView = _separatorView
    private lazy var tableView: UITableView = _tableView
    
    let events = EventModel.events
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMonth()
        setupYear()
        
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
    
    func setupYear() {
        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: self.calendar.currentPage)
        yearLabel.text = "\(values.year!)"
    }
    
    func setupMonth() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let monthName = dateFormatter.string(from: calendar.currentPage).capitalized
        monthLabel.text = monthName
    }
}

extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        calendar.appearance.todayColor = .clear
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        setupMonth()
        setupYear()
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: CustomCalendarCell.reuseIdentifier, for: date, at: position) as! CustomCalendarCell
        
        cell.clearEventDots()
        
        let dateString = dateFormatter.string(from: date)
        let currentDate = Date()
        let isToday = Calendar.current.isDate(date, inSameDayAs: currentDate)
        
        if let events = events[dateString] {
            cell.addEventDots(isToday: isToday, events: events, areAlreadyExist: true)
        }
        return cell
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell

        let event = Event.events[indexPath.row]
        cell.setIcons(event.icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func resetEventDict() {
        Event.eventDict = [
            Event.infoEvent : 0,
            Event.doctorEvent : 0,
            Event.vaccinationEvent : 0
        ]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let date = dateFormatter.string(from: selectedDate)
        var eventsArray = EventModel.events[date] != nil ? EventModel.events[date]! : []; resetEventDict()
        
        let newEvent = createEventForIndexPath(indexPath)
        eventsArray.append(newEvent)
        
        updateEventModelData(date: date, events: eventsArray)
        
        updateTableViewCell(at: indexPath, with: newEvent)
        updateCalendarCell(for: selectedDate, with: eventsArray)
    }
    
    func createEventForIndexPath(_ indexPath: IndexPath) -> EventModel {
        switch indexPath.row {
        case 0:
            return EventModel(event: Event.infoEvent, title: "Позвонить дедушке")
        case 1:
            return EventModel(event: Event.doctorEvent, title: "Пройти медосмотр", subtitle: "Окулист")
        case 2:
            return EventModel(event: Event.vaccinationEvent, title: "Пойти к доктору на укол", subtitle: "Тектраксин")
        default:
            fatalError("Unknown indexPath")
        }
    }
    
    func updateEventModelData(date: String, events: [EventModel]) {
        EventModel.events[date] = events
        EventModel.countEvents(selectedDate: date)
    }
    
    func updateTableViewCell(at indexPath: IndexPath, with event: EventModel) {
        if let tableCell = tableView.cellForRow(at: indexPath) as? TableViewCell {
            tableCell.currentCell = indexPath.row
            tableCell.addEvent(title: event.title ?? "", subtitle: event.subtitle ?? "")
            tableCell.toggleExpansion()
        }
    }

    func updateCalendarCell(for date: Date, with events: [EventModel]) {
        if let calendarCell = calendar.cell(for: date, at: .current) as? CustomCalendarCell {
            calendarCell.addEventDots(isToday: false, events: events, areAlreadyExist: false)
        }
    }
}

private extension CalendarViewController {
    
    var _dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
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
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        return tableView
    }
}
