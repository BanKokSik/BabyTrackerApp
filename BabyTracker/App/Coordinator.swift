//
//  Coordinator.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 17.07.2023.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var parent: Coordinator? { get set }
    
    func start()
    func entry() -> UIViewController
}

protocol Coordinatable: AnyObject {
    var coordinator: Coordinator? { get set }
}
