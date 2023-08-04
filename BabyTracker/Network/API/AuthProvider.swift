//
//  AuthProvider.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 03.08.2023.
//

import Foundation

protocol AuthProvider: AnyObject {
    var token: String? { get set }
    var isAuth: Bool { get }
}

class AuthProviderImpl: AuthProvider {
    var token: String?
    
    var isAuth: Bool {
        token != nil ? true : false
    }
}
