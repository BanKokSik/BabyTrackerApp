//
//  AuthNetwork.swift
//  BabyTracker
//
//  Created by Мявкo on 13.07.23.
//

import Alamofire

protocol AuthNetwork: AnyObject {
    
    func registerToken(device: String)
    
}

class AuthNetworkImpl: AuthNetwork {
    
    func registerToken(device: String) {
        
    }
    
}
