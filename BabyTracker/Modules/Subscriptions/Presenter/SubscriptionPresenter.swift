//
//  SubscriptionPresenter.swift
//  BabyTracker
//
//  Created by Мявкo on 24.07.23.
//

import Foundation

protocol SubscriptionPresenterDelegate: AnyObject {
    var subscriptionVC: SubscriptionViewController? { get }
    var getTextForDescription: (Subscription) -> String { get }
    
    func getTextForSubscriptionLabels()
}

class SubscriptionPresenter {
    weak var subscriptionVC: SubscriptionViewController?
    
    init(_ controller: SubscriptionViewController) {
        subscriptionVC = controller
    }
    
    func getTextForSubscriptionLabels(period: Subscription) -> (title: String, price: NSAttributedString) {
        var titleText: String
        var priceText: NSAttributedString
        
        switch period {
        case .year:
            titleText = R.string.localizable.subscriptionForAYearLabel()
            priceText = NSAttributedString(string: R.string.localizable.subscriptionForAYearPriceLabel())
        case .month:
            titleText = R.string.localizable.subscriptionForAMonthLabel()
            priceText = NSAttributedString(string: R.string.localizable.subscriptionForAMonthPriceLabel())
        case .forever:
            titleText = R.string.localizable.subscriptionForeverLabel()
            priceText = subscriptionVC!.strikethroughText
        }
        return (title: titleText, price: priceText)
    }
    
    var getTextForDescription: (Subscription) -> String = { period in
        var description: String
        
        switch period {
        case .year:
            description = R.string.localizable.describeSubscriptionForAYearTextView()
        case .month:
            description = R.string.localizable.describeSubscriptionForAMonthTextView()
        case .forever:
            description = R.string.localizable.describeSubscriptionForeverTextView()
        }
        return description
    }
}
