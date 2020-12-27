//
//  Presenter.swift
//  Viper Task
//
//  Created by Apple on 16/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

class Presenter {
    var view: PresenterOutputProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
}


extension Presenter: PresenterInputProtocol {
    func fetchInfo() {
        interactor?.fetchInfo()
    }
    
    func saveInfo(info: Info) {
        interactor?.saveInfo(info: info)
    }
    
   
    func getResponse(url: String, params: [String : Any], _ completion: @escaping (_ isSuccess: Bool) -> Void) {
        interactor?.fetchResponse(url: url, params: params, completion)
    }
    
    func fetchingDb() {
        interactor?.fetchDb()
    }
    
    func savingDb(mobNo: MobNo) {
        interactor?.saveDb(mobNo: mobNo)
    }
    
    
}

extension Presenter: InteractorToPresenterProtocol {
    func dBInfoDataSuccess(info: Array<Info>) {
        view?.getInfoData(info: info)
    }
    

    
    func dataSuccess(dic: NSDictionary) {
        view?.showSuccess(dic: dic)
    }
    
    func dataError(error: CustomError) {
        view?.showError(error: error)
    }
    
    func dBdataSuccess(mobNos: Array<MobNo>) {
        view?.getData(mobNos: mobNos)
    }
    
    func dBdataError() {
        view?.showSaveError()
    }
    
    
}
