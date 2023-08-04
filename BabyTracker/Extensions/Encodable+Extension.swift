//
//  Encodable+Extension.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 04.08.2023.
//

import Foundation

extension Encodable {
    
    func asDictionary() -> [String: Any] {
        let data = try! JSONEncoder().encode(self)
        guard let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [String: Any]()
        }
        return dictionary
    }
}
