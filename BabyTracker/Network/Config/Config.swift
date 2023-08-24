//
//  Config.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 03.08.2023.
//

import Foundation

protocol Config {
    var baseURL: String { get }
}

extension Config {
    var baseURL: String {
        return "http://207.154.221.232"
    }
}

class DefaultConfig: Config {
    
}
