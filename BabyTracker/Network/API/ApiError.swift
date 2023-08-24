//
//  ApiError.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 03.08.2023.
//

import Foundation

enum ApiError: Error {
    case badResponse
    case unknown
    case unauthorized
    case server
    
    static func byHttpStatusCode(_ code: Int) -> ApiError {
        switch code {
        case 401:
            return .unauthorized
        case 500:
            return .server
        default:
            return .unknown
        }
    }
}
