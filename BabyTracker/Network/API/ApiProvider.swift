//
//  ApiProvider.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 03.08.2023.
//

import Foundation
import Alamofire

class ApiProvider {
    var apiSessionProvider: ApiSessionProvider
    
    init(apiSessionProvider: ApiSessionProvider) {
        self.apiSessionProvider = apiSessionProvider
    }
    
    func requestAF(route: ApiRoute) -> DataRequest? {
        var components = apiSessionProvider.sessioned(route: route).apiComponents
        let request = AF.request(components.url,
                   method: components.method,
                   parameters: components.data,
                   encoding: components.encoding,
                   headers: components.headers)
        request.cURLDescription(calling: { (desc) in
            print(desc)
        })
        return request
    }
    
    // Parse DataResponse into Codable Object
    internal func parseDataResponse<T: Codable>(response: AFDataResponse<Any>) throws -> T {
        guard let code = response.response?.statusCode else {
            throw ApiError.unknown
        }
        guard code >= 200, code < 300 else {
            throw ApiError.byHttpStatusCode(code)
        }
        guard let data = response.data else {
            throw ApiError.badResponse
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error)
            throw ApiError.badResponse
        }
    }
}
