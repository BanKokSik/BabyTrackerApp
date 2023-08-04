//
//  UserModel.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 03.08.2023.
//

import Foundation

struct DeviceModel: Codable, Equatable {
    var token: String
    var user: UserModel
}

struct UserModel: Codable, Equatable {
    var id: String = "1"
    var name: String = "User"
    var isPremium: Int?
    var metricSystem: Int?
    var children: [ChildrenModel] = []
    var country: String? = "en_US"
    var email: String?
    var relatives: [RelativesModel] = []
    
    init(id: String) {
        self.id = id
    }
}

struct ChildrenModel: Codable, Equatable {
    var id: String = "1"
    var name: String?
    var photo: String? = "empty"
    var photoData: Data?
    var controlable: Int?
    var gender: String?
    var birthDate: String?
    var weight: Double? = 0
    var height: Double? = 0
    
    init() {}
    
    init(id: String, name: String?, photo: String?, photoData: Data?, controlable: Int?, gender: String?, birthDate: String?, weight: Double?, height: Double?) {
        self.id = id
        self.name = name
        self.photo = photo
        self.photoData = photoData
        self.controlable = controlable
        self.gender = gender
        self.birthDate = birthDate
        self.weight = weight
        self.height = height
    }
}

struct RelativesModel: Codable, Equatable {
    var id: String
    var name: String?
    
    init(id: String, name: String?) {
        self.id = id
        self.name = name
    }
}
