//
//  RouterPresenter.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 10.07.2023.
//

import UIKit

protocol RouterPresenterProtocol: AnyObject {
    func start()
    func setWindow(_ window: UIWindow)
}

class RouterPresenter: RouterPresenterProtocol {
    weak var view: RouterProtocol?
    
    func entry() -> UIWindow {
        guard let rootView = view as? UIWindow else {
            fatalError("RootView is not UIWindow instance")
        }
        return rootView
    }
    
    func start() {
        let loadView = LoaderViewController()
        let nextVC = UINavigationController(rootViewController: RegisterViewController())
        loadView.delegate = self
        loaderView = loadView
        entry().rootViewController = loaderView
        let queue = DispatchQueue.global(qos: .utility)
        queue.asyncAfter(deadline: .now() + 3.0) {
            DispatchQueue.main.async {
                self.entry().rootViewController = nextVC
            }
            
        }
    }
    
    func setWindow(_ window: UIWindow) {
        self.view = window as? RouterProtocol
    }
    
    
    private var loaderView: LoaderViewController?

}

extension RouterPresenter: LoaderViewControllerDelegate {
    
}



