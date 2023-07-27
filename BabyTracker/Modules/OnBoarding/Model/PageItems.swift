//
//  OnBoardingPage.swift
//  BabyTracker
//
//  Created by Мявкo on 2.07.23.
//

import UIKit

struct PageItems {
    let image: UIImage?
    let textLabel: String
    
    static let pages = [
        PageItems(image: R.image.onBoardingPage1(), textLabel: R.string.localizable.onbordingLabelPage1()),
        PageItems(image: R.image.onBoardingPage2(), textLabel: R.string.localizable.onbordingLabelPage2()),
        PageItems(image: R.image.onBoardingPage3(), textLabel: R.string.localizable.onbordingLabelPage3()),
        PageItems(image: R.image.onBoardingPage4(), textLabel: R.string.localizable.onbordingLabelPage4())
    ]
}
