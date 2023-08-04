//
//  ApiRoute.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 03.08.2023.
//

import Foundation
import Alamofire

struct ApiRoute {
    var apiComponents: ApiComponents
    var apiSessionType: ApiSessionType
}

protocol ApiRouter {
    var config: Config { get }
    var baseURL: String { get }
    var apiRoute: ApiRoute { get }
}

extension ApiRouter {
    var baseURL: String {
        return config.baseURL
    }
    
    var apiRoute: ApiRoute {
        let components = ApiComponents(url: baseURL,
                                       method: .get,
                                       encoding: URLEncoding.default,
                                       data: nil,
                                       headers: nil,
                                       multipartItems: nil)
        let apiRoute = ApiRoute(apiComponents: components, apiSessionType: .header)
        return apiRoute
    }
}
