//
//  CreateProfilePresenter.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 11.07.2023.
//

import UIKit

protocol CreateProfilePresenter: AnyObject{
    var view: CreateProfileView? { get set }
    func didLoad()
    func createUserProfile()
    func setChild(name: String)
    func setChild(birthday: Date)
    func setChild(gender: Gender)
}

class CreateProfilePresenterImpl: CreateProfilePresenter {
    weak var view: CreateProfileView?
    
    var userProvider: UserApiProvider
    
    init(view: CreateProfileView? = nil, userProvider: UserApiProvider) {
        self.view = view
        self.userProvider = userProvider
    }
    
    func didLoad() {
        
    }
    
    func createUserProfile() {
        guard let name = name,
              let gender = gender,
              let birthDate = birthDate else {
            return
            #warning("It would be nice to show some error message here")
        }
        guard let userId = UserDefaultsSettings.userId else {
            return
            #warning("It would be nice to show some error message here")
        }
        var newUser = UserModel(id: userId)
        newUser.metricSystem = 1
        var newChildren = ChildrenModel()
        newChildren.controlable = 1
        newChildren.weight = 0
        newChildren.height = 0
        newChildren.name = name
        newChildren.gender = gender.value
        newChildren.birthDate = birthDate.getFormatterDate(dateFormat: "yyyy-MM-dd")
        newUser.children = []
        newUser.children.append(newChildren)
        userProvider.updateUser(user: newUser) { userModel in
            
        }
    }
    
    func setChild(name: String) {
        self.name = name
    }
    
    func setChild(gender: Gender) {
        self.gender = gender
    }
    
    func setChild(birthday: Date) {
        self.birthDate = birthday
    }
    
    //MARK: - Private
    
    private var gender: Gender?
    private var name: String?
    private var birthDate: Date?
    
}

