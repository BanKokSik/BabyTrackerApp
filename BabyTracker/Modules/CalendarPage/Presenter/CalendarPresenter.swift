//
//  CalendarPresenter.swift
//  BabyTracker
//
//  Created by Мявкo on 16.08.23.
//

import Foundation
import FSCalendar

protocol CalendarPresenterProtocol: AnyObject {
    var getHeightForRow: CGFloat { get }
    static var dateFormatter: DateFormatter { get }
    var getActualCellAlpha: (Bool) -> Double { get }
    var getStringDate: (Date) -> String { get }
    
    func getYearValue(from calendar: FSCalendar) -> Int
    func getMonthValue(from calendar: FSCalendar) -> String
    func getDateData(cellFor date: Date) -> (date: String, isToday: Bool)
    func resetEventDict()
    func createEventForIndexPath(_ indexPath: IndexPath) -> EventModel
    func updateEventModelData(date: Date, events: [EventModel])
    func updateTableViewCell(_ tableView: UITableView, at indexPath: IndexPath, with event: EventModel)
    func updateCalendarCell(_ calendar: FSCalendar, for date: Date, with events: [EventModel])
    func initEventsArray(date: Date, indexPath: IndexPath) -> [EventModel]
}


class CalendarPresenter: CalendarPresenterProtocol {
    
    var getHeightForRow: CGFloat {
        return 60
    }
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    var getActualCellAlpha: (Bool) -> Double = { cellIsSelected in
        return cellIsSelected ? 1.0 : 0.5
    }
    
    func getYearValue(from calendar: FSCalendar) -> Int {
        let monthComponent = Calendar.Component.month
        let yearComponent = Calendar.Component.year
        
        let dateComponents = Calendar.current.dateComponents([monthComponent, yearComponent], from: calendar.currentPage)
        return dateComponents.year!
    }
    
    func getMonthValue(from calendar: FSCalendar) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let monthName = dateFormatter.string(from: calendar.currentPage).capitalized
        return monthName
    }
    
    var getStringDate: (Date) -> String = { date in
        return dateFormatter.string(from: date)
    }
    
    func getDateData(cellFor date: Date) -> (date: String, isToday: Bool) {
        let dateString = getStringDate(date)
        let currentDate = Date()
        let isToday = Calendar.current.isDate(date, inSameDayAs: currentDate)
        return (dateString, isToday)
    }
    
    func resetEventDict() {
        Event.eventDict = [
            Event.infoEvent : 0,
            Event.doctorEvent : 0,
            Event.vaccinationEvent : 0
        ]
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
    
    func updateEventModelData(date: Date, events: [EventModel]) {
        let dateString = getStringDate(date)
        EventModel.events[dateString] = events
        EventModel.countEvents(selectedDate: dateString)
    }
    
    func updateTableViewCell(_ tableView: UITableView, at indexPath: IndexPath, with event: EventModel) {
        if let tableCell = tableView.cellForRow(at: indexPath) as? CalendarTableViewCell {
            tableCell.currentCell = indexPath.row
            tableCell.addEvent(title: event.title ?? "", subtitle: event.subtitle ?? "")
            tableCell.toggleExpansion()
        }
    }

    func updateCalendarCell(_ calendar: FSCalendar, for date: Date, with events: [EventModel]) {
        if let calendarCell = calendar.cell(for: date, at: .current) as? CustomCalendarCell {
            calendarCell.addEventDots(isToday: false, events: events, areAlreadyExist: false)
        }
    }
    
    func initEventsArray(date: Date, indexPath: IndexPath) -> [EventModel] {
        let dateString = getStringDate(date)
        var eventsArray = [EventModel]()
        
        if let existingEvents = EventModel.events[dateString] {
            eventsArray = existingEvents
        } else {
            resetEventDict()
        }
        
        return eventsArray
    }
}
