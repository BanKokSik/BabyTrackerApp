//
//  EventModel.swift
//  BabyTracker
//
//  Created by Мявкo on 8.08.23.
//

import UIKit

struct Event : Equatable, Hashable {
    var icon: UIImage?
    var color: UIColor?
    
    static let infoEvent = Event(icon: R.image.infoIcon(), color: R.color.dodgerBlue())
    static let doctorEvent = Event(icon: R.image.doctorIcon(), color: R.color.bittersweet())
    static let vaccinationEvent = Event(icon: R.image.vaccinationIcon(), color: R.color.razzleDazzleRose())
    
    static var events = [infoEvent, doctorEvent, vaccinationEvent]
    
    static var eventDict = [
        infoEvent : 0,
        doctorEvent : 0,
        vaccinationEvent : 0
    ]
}

struct EventModel : Equatable {
    var event: Event?
    var title: String?
    var subtitle: String?
    
    static var events = [
        "2023-08-08" : [
            EventModel(event: Event.infoEvent, title: "Позвонить бабушке"),
            EventModel(event: Event.doctorEvent, title: "Пройти медосмотр", subtitle: "Окулист"),
            EventModel(event: Event.vaccinationEvent, title: "Пойти к доктору на укол", subtitle: "Тектраксин")
        ],
        "2023-08-12" : [
            EventModel(event: Event.infoEvent, title: "Позвонить бабушке"),
            EventModel(event: Event.doctorEvent, title: "Пройти медосмотр", subtitle: "Окулист")
        ],
        "2023-08-17" : [
            EventModel(event: Event.vaccinationEvent, title: "Пойти к доктору на укол", subtitle: "Тектраксин")
        ]
    ]
    
    static func countEvents(selectedDate: String) {
        if let eventsArray = EventModel.events[selectedDate] {
            for eventModel in eventsArray {
                if let event = eventModel.event {
                    Event.eventDict[event]! += 1
                }
            }
        }
    }
}
