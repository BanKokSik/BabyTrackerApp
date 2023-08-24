//
//  ApiSessionProvider.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 03.08.2023.
//

import Foundation
import Alamofire

enum ApiSessionType {
    case none
    case header
}

protocol ApiSessionProvider: AnyObject {
    func sessioned(route: ApiRoute) -> ApiRoute
}

class ApiSessionProviderImpl: ApiSessionProvider {
    var authProvider: AuthProvider
    
    init(authProvider: AuthProvider) {
        self.authProvider = authProvider
    }
    
    func sessioned(route: ApiRoute) -> ApiRoute {
        var sessionedRoute = route
        let headers = sessionedRoute.apiComponents.headers ?? [:]
        sessionedRoute.apiComponents.headers = headers
        
        switch sessionedRoute.apiSessionType {
        case .header:
            if authProvider.isAuth {
                let token = authProvider.token
                var headers: HTTPHeaders = [.authorization(bearerToken: token!)]
                sessionedRoute.apiComponents.headers = headers
            }
        case .none:
            break
        }
        return sessionedRoute
    }
}
