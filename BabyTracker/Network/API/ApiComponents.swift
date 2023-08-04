//
//  ApiComponents.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 03.08.2023.
//

import Foundation
import Alamofire

struct ApiComponents {
    var url: String
    var method: HTTPMethod
    var encoding: ParameterEncoding
    var data: [String: Any]?
    var headers: HTTPHeaders?
    var multipartItems: [MultipartItem]?
}
