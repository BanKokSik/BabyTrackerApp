//
//  MultipartItem.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 03.08.2023.
//

import Foundation

struct MultipartItem {
    public var data: Data?
    public var fileURL: URL?
    public var name: String
    public var fileName: String?
    public var mimeType: String?

    public init(data: Data, name: String, fileName: String?, mimeType: String) {
        self.data = data
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }

    public init(fileURL: URL, name: String) {
        self.fileURL = fileURL
        self.name = name
    }

    public init(value: String, name: String) {
        self.data = value.data(using: .utf8)
        self.name = name
        self.fileName = nil
        self.mimeType = nil
    }
}
