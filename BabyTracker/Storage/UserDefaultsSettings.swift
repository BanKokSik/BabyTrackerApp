//
//  UserDefaultsSetings.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 29.06.2023.
//

import UIKit

 class UserDefaultsSettings{
    
    private enum SettingsKeys: String{
        case deviceId
    }

   static var setupDeviceId: String?{
        
        get{
            return UserDefaults.standard.string(forKey: SettingsKeys.deviceId.rawValue)
        }
        set{
            let defaults = UserDefaults.standard
            if let id = newValue {
                defaults.set(id, forKey: SettingsKeys.deviceId.rawValue)
            }
            
        }
        
    }
}
