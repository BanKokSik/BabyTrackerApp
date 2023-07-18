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
    func didLoad()
}


class PagePresenter: PagePresenterProtocol {
    
    weak var view: PageViewProtocol?
    
    var pages = PageItems.pages
    
    lazy var nextPageIndex = { (currentPage: Int) -> Int in
        return min(currentPage + 1, self.pages.count - 1)
    }
    
    lazy var previousPageIndex = { (currentPage: Int) -> Int in
        return max(currentPage - 1, 0)
    }
    
    init(view: PageViewProtocol? = nil) {
        self.view = view
    }
    
    func didLoad() {
        
    }
    
    func scrollToItem(index: Int, _ collectionView: UICollectionView) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
