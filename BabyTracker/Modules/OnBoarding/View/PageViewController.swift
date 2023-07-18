//
//  OnBoardingPresenter.swift
//  BabyTracker
//
//  Created by Мявкo on 2.07.23.
//


import UIKit

protocol PageViewControllerDelegate: AnyObject {
    
}

protocol PageViewProtocol: AnyObject {
    
}

class PageViewController: UIViewController {
    
    var presenter: PagePresenterProtocol
    weak var delegate: PageViewControllerDelegate?
    
    weak var coordinator: Coordinator?
    private var onboardingCoordinator: OnboardingCoordinator? { coordinator as? OnboardingCoordinator }
    
    private lazy var nextButton: UIButton = _nextButton
    private lazy var pageControl: UIPageControl = _pageControl
    private lazy var collectionView: UICollectionView = _collectionView
    
    init() {
        presenter = PagePresenter()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
        configureSwipes()
    }
    
    func scrollToItem(index: Int, _ collectionView: UICollectionView) {
        guard index < presenter.pages.count else { return }
        
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func handleSwipeLeft() {
        let nextIndex = swipeOrFinishOnbording()
        setPage(index: nextIndex)
    }

    @objc func handleSwipeRight() {
        let previousIndex = presenter.previousPageIndex(pageControl.currentPage)
        setPage(index: previousIndex)
    }
    
    @objc func pageControlDidTap() {
        scrollToItem(index: pageControl.currentPage, collectionView)
    }
    
    @objc func nextButtonDidTap() {
        _ = swipeOrFinishOnbording()
    }
    
    func swipeOrFinishOnbording() -> Int {
        let nextIndex = presenter.nextPageIndex(pageControl.currentPage)
        
        if nextIndex != presenter.pages.count {
            pageControl.currentPage = nextIndex
            scrollToItem(index: nextIndex, collectionView)
        } else {
            onboardingCoordinator?.didFinish()
        }
        return nextIndex
    }
    
    func setPage(index: Int) {
        pageControl.currentPage = index
        scrollToItem(index: index, collectionView)
    }
}

extension PageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.pages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell.reuseIdentifier, for: indexPath) as! PageCell
        let pageItem = presenter.pages[indexPath.item]
        cell.update(image: pageItem.image!, text: pageItem.textLabel)
        return cell
    }
}

extension PageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension PageViewController {
    
    var _pageControl: UIPageControl {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = presenter.pages.count
        pageControl.pageIndicatorTintColor = R.color.heliotropeLight()
        pageControl.currentPageIndicatorTintColor = R.color.heliotrope()
        pageControl.addTarget(self, action: #selector(pageControlDidTap), for: .valueChanged)
        return pageControl
    }
    
    var _nextButton: UIButton {
        let button = UIButton(type: .system)
        button.setTitle(R.string.localizable.nextButton(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundColor(R.color.heliotrope(), for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        return button
    }
    
    var _collectionView: UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: PageCell.reuseIdentifier)
        return collectionView
    }
    
    func configureSwipes() {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        swipeLeftGesture.direction = .left
        view.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeRightGesture.direction = .right
        view.addGestureRecognizer(swipeRightGesture)
    }
    
    func layout() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.width.equalToSuperview()
            make.height.equalTo(710)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(190)
            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(60)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(70)
        }
    }
}
