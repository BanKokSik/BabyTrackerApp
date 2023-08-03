//
//  TabBarController.swift
//  BabyTracker
//
//  Created by Мявкo on 3.08.23.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    weak var coordinator: Coordinator?
    private var tabBarCoordinator: CustomTabBarCoordinator? { coordinator as? CustomTabBarCoordinator }
    
    private lazy var flowLayout: UICollectionViewFlowLayout = _flowLayout
    private lazy var collectionView: UICollectionView = _collectionView
    
    private var selectedCellIndex = 0
    
    private let cellImages = CustomTabCellModel.images
    private let controllers: [UIViewController] = [FirstViewController(),
                                                   SecondViewController(),
                                                   ThirdViewController(),
                                                   FourthViewController(),
                                                   FifthViewController(),
                                                   SixthViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTabBarAppearance()
        setupSubviews()
        applyConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(collectionView)
    }
    
    private func applyConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(100)
        }
    }
    
    private func setupTabBarAppearance() {
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 10
        
        removeTabBarTopBorder()
    }
    
    private func removeTabBarTopBorder() {
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }
    
    private func setupViewController(at indexPath: IndexPath) {
        let viewController = controllers[indexPath.item]
        addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
}

extension CustomTabBarController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomTabCell.cellIdentifier, for: indexPath) as! CustomTabCell

        cell.setImage(cellImages[indexPath.item].image)
        cell.updateCell(isSelected: indexPath.row == selectedCellIndex)
        
        setupViewController(at: indexPath)
        
        return cell
    }
}

extension CustomTabBarController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCellIndex = indexPath.row
        selectedIndex = selectedCellIndex
        selectedViewController = controllers[indexPath.row]
        collectionView.reloadData()
    }
}

extension CustomTabBarController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 71, height: 71)
    }
}

extension CustomTabBarController {
    
    var _flowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        return layout
    }
    
    var _collectionView: UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomTabCell.self, forCellWithReuseIdentifier: CustomTabCell.cellIdentifier)
        return collectionView
    }
}

