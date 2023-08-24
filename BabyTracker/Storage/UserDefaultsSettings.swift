//
//  UserDefaultsSetings.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 29.06.2023.
//

import UIKit

 class UserDefaultsSettings{
    
    private enum SettingsKeys: String {
        case deviceId
        case userId
    }

   static var setupDeviceId: String?{
        
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.deviceId.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            if let id = newValue {
                defaults.set(id, forKey: SettingsKeys.deviceId.rawValue)
            }
            
        }
    }
     
     static var userId: String? {
         get {
             return UserDefaults.standard.string(forKey: SettingsKeys.userId.rawValue)
         }
         
         set {
             if let userId = newValue {
                 UserDefaults.standard.set(userId, forKey: SettingsKeys.userId.rawValue)
             }
         }
     }
}
