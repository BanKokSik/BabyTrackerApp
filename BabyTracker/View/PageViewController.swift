//
//  PageViewController.swift
//  BabyTracker
//
//  Created by Мявкo on 28.06.23.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var pageControl = UIPageControl()
    var pages = [
        OnBoardingViewController(image: R.image.onBoardingPage1()!, textLabel: "Планируйте развитие"),
        OnBoardingViewController(image: R.image.onBoardingPage2()!, textLabel: "Сохраняйте моменты"),
        OnBoardingViewController(image: R.image.onBoardingPage3()!, textLabel: "Следите за показателями"),
        OnBoardingViewController(image: R.image.onBoardingPage4()!, textLabel: "Получайте рекомендации")
    ]

    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setup()
    }
    
    func setup() {
        dataSource = self
        delegate = self
        
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        
        setupPageControl()
        layoutPageControl()
    }
    
    func updatePageControl() {
        guard let currentPage = viewControllers?.first,
              let currentIndex = pages.firstIndex(of: currentPage as! OnBoardingViewController) else { return }
        pageControl.currentPage = currentIndex + 1
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
}

extension PageViewController {
    func setupPageControl() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = pages.count
        pageControl.pageIndicatorTintColor = R.color.heliotropeLight()
        pageControl.currentPageIndicatorTintColor = R.color.heliotrope()
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
    }
    
    func layoutPageControl() {
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(190)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - DataSources

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController as! OnBoardingViewController), currentIndex > 0 else { return nil }
        
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController as! OnBoardingViewController), currentIndex < pages.count - 1 else { return nil }
        
        return pages[currentIndex + 1]
    }
}

// MARK: - Delegates

extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers,
              let currentViewController = viewControllers.first as? OnBoardingViewController,
              let currentIndex = pages.firstIndex(of: currentViewController) else { return }
        
        pageControl.currentPage = currentIndex
    }
}

extension PageViewController: OnBoardingViewControllerDelegate {
    func didTapNextButton() {
        
        guard let currentPage = viewControllers?.first as? OnBoardingViewController,
              let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        updatePageControl()
        setViewControllers([nextPage], direction: .forward, animated: true)
    }
}

