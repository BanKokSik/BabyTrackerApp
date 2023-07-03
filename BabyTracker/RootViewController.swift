//
//  RootViewController.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 29.06.2023.
//

import UIKit

class RootViewController: UIViewController {

    private var current = UIViewController()
    
    init() {
        self.current = LoaderViewController()
        super .init(nibName: nil, bundle: nil)
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
        showNextVC()

      
    }
    func showRegisterVC(){
        let new = UINavigationController(rootViewController: RegisterViewController())
        
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }
    func showNextVC() {
        let queue = DispatchQueue.global(qos: .utility)
        queue.asyncAfter(deadline: .now() + 3.0) {
            DispatchQueue.main.async {
                self.showRegisterVC()
            }
            
        }
        
    }

   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


