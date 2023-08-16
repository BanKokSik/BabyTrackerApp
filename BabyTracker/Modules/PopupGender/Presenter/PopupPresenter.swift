//
//  PopupPresenter.swift
//  BabyTracker
//
//  Created by Мявкo on 12.07.23.
//

protocol PopupPresenterProtocol {
    var popupVC: PopupViewController? { get }
    var boy: GenderModel { get }
    var girl: GenderModel { get }
    var gender: Gender? { get }
    
    func whoHasCheckmark()
    func genderIsTapped()
    func toggleActiveState()
}

class PopupPresenter: PopupPresenterProtocol {
    
    weak var popupVC: PopupViewController?
    
    let boy = GenderModel(image: R.image.boy(), title: R.string.localizable.genderBoyLabel())
    let girl = GenderModel(image: R.image.girl(), title: R.string.localizable.genderGirlLabel())
    
    var gender: Gender?
    
    init(_ controller: PopupViewController) {
        popupVC = controller
        popupVC?.delegate = self
    }
    
    func whoHasCheckmark() {
        switch gender {
        case .girl:
            popupVC?.layoutCheckmarkOnGirl()
        case .boy:
            popupVC?.layoutCheckmarkOnBoy()
        default: break
        }
    }
    
    func genderIsTapped() {
        toggleActiveState()
        whoHasCheckmark()
        
        popupVC?.hidePopup()
    }
    
    func toggleActiveState() {
        switch gender {
        case .girl:
            popupVC?.toggleViewActiveStateOnGirl()
            popupVC?.setValueInTextField(girl.title)
        case .boy:
            popupVC?.toggleViewActiveStateOnBoy()
            popupVC?.setValueInTextField(boy.title)
        default: break
        }
    }
}

extension PopupPresenter: PopupPresenterDelegate {
    
    func didSelectGender(_ controller: PopupViewController, gender: Gender?) {
        self.gender = gender
        genderIsTapped()
    }
}
