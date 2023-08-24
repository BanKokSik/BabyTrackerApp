//
//  EventFeedPresenter.swift
//  BabyTracker
//
//  Created by Мявкo on 16.08.23.
//

import Foundation

protocol EventFeedPresenterProtocol: AnyObject {}


class EventFeedPresenter: EventFeedPresenterProtocol {
    
    let data = [4 : "70см", 5 : "40кг 820г"]
    let times = ["21-20", "22-20", "19-10", "15-20"]
    
    var getHeightForRow: CGFloat {
        return 70
    }
    
    func setupCells(for cell: FeedTableViewCell, index: Int) {
        if index < 4 {
            cell.setTime(times[index])
            cell.setupEventsViews()
        } else {
            cell.setData(data[index]!)
        }
    }
    
    func setupSeparator(for cell: FeedTableViewCell, index: Int) {
        let iconsLength = EventFeedModule.icons.count - 1
        if index < iconsLength {
            cell.setupSeparator()
        }
    }
}
