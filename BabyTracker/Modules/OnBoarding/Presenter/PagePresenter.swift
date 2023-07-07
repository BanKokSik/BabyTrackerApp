//
//  PagePresenter.swift
//  BabyTracker
//
//  Created by Мявкo on 7.07.23.
//

import UIKit

protocol PagePresenterProtocol: AnyObject {
    var pages: [PageItems] { get }
    var nextPageIndex: (_ currentPage: Int) -> (Int) { get set }
    var previousPageIndex: (_ currentPage: Int) -> (Int) { get set }
    func scrollToItem(index: Int, _ collectionView: UICollectionView)
}


class PagePresenter: PagePresenterProtocol {
    
    let pages = [
        PageItems(image: R.image.onBoardingPage1(), textLabel: R.string.localizable.onbordingLabelPage1()),
        PageItems(image: R.image.onBoardingPage2(), textLabel: R.string.localizable.onbordingLabelPage2()),
        PageItems(image: R.image.onBoardingPage3(), textLabel: R.string.localizable.onbordingLabelPage3()),
        PageItems(image: R.image.onBoardingPage4(), textLabel: R.string.localizable.onbordingLabelPage4())
    ]
    
    lazy var nextPageIndex = { (currentPage: Int) -> Int in
        return min(currentPage + 1, self.pages.count - 1)
    }
    
    lazy var previousPageIndex = { (currentPage: Int) -> Int in
        return max(currentPage - 1, 0)
    }
    
    func scrollToItem(index: Int, _ collectionView: UICollectionView) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
