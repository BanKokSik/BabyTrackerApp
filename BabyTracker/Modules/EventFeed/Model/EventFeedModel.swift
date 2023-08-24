//
//  EventFeedModel.swift
//  BabyTracker
//
//  Created by Мявкo on 16.08.23.
//

import UIKit

struct EventFeedModule {
    var image: UIImage?
    
    static let icons = [
        EventFeedModule(image: R.image.starIcon()),
        EventFeedModule(image: R.image.infoIcon()),
        EventFeedModule(image: R.image.vaccinationIcon()),
        EventFeedModule(image: R.image.doctorIcon()),
        EventFeedModule(image: R.image.rulerIcon()),
        EventFeedModule(image: R.image.scalesIcon())
    ]
}
