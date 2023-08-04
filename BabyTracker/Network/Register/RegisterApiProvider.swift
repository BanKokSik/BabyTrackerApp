//
//  AuthNetwork.swift
//  BabyTracker
//
//  Created by Мявкo on 13.07.23.
//

import Alamofire

protocol RegisterApiProvider: AnyObject {
    var router: RegisterRouter { get }
    var authProvider: AuthProvider { get }
    var apiSessionProvider: ApiSessionProvider { get }
    
    func registerToken(device: String)
    
}

class RegisterApiProviderImpl: ApiProvider, RegisterApiProvider {
    var router: RegisterRouter
    var authProvider: AuthProvider
    
    init(router: RegisterRouter,
         authProvider: AuthProvider,
         apiSessionProvider: ApiSessionProvider) {
        self.router = router
        self.authProvider = authProvider
        super.init(apiSessionProvider: apiSessionProvider)
    }
    
    func registerToken(device: String) {
        let route = router.registerToken(device: device)
        let request = requestAF(route: route)
        request?.responseJSON(completionHandler: { [weak self, authProvider] response in
            do {
                let device: DeviceModel? = try self?.parseDataResponse(response: response)
                guard let userId = device?.user.id,
                      let token = device?.token else {
                    return
                }
                authProvider.token = token
                UserDefaultsSettings.userId = userId
            } catch {
                #warning("It would be great to handle Api errors here")
            }
        })
    }
    
}
