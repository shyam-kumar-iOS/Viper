//
//  protocol.swift
//  Viper Task
//
//  Created by Apple on 16/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

protocol PresenterInputProtocol: class {
    
    // view to presenter
    
    var view: PresenterOutputProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    
    func getResponse(url: String, params: [String : Any],_ completion: @escaping (_ isSuccess: Bool) -> Void)
    func fetchingDb()
    func savingDb(mobNo: MobNo)
    func fetchInfo()
    func saveInfo(info: Info)
    
}

protocol PresenterOutputProtocol: class {
    
    // presenter to view
    
    func showSuccess(dic: NSDictionary)
    func showError(error: CustomError)
    func getData(mobNos:Array<MobNo>)
    func showSaveError()
   // func savetoDb(mobNo: MobNo)
    func getInfoData(info:Array<Info>)
   // func saveInfo(info: Info)
    

}

protocol PresenterToInteractorProtocol: class {
   
    // interactor input
    var presenter:InteractorToPresenterProtocol? {get set}
    var webService : WebServiceProtocol? {get set}
    func fetchResponse(url: String, params: [String: Any],_ completion: @escaping (_ isSuccess: Bool) -> Void)
    func fetchDb()
    func saveDb(mobNo: MobNo)
    func fetchInfo()
    func saveInfo(info: Info)
    
}

protocol InteractorToPresenterProtocol: class {
    
    // interactor output
    
    func dataSuccess(dic: NSDictionary)
    func dataError(error : CustomError)
    func dBdataSuccess(mobNos:Array<MobNo>)
    func dBdataError()
    func dBInfoDataSuccess(info:Array<Info>)
    
}

protocol WebServiceProtocol: class {
    
    var interactor: WebServiceToInteractor? {get set}
    
    func retrieve(url: String, params: [String : Any], _ completion: @escaping (_ isSuccess: Bool) -> Void)
    func retrieveDb()
    func retrieveInfo()
    func saveDb(mobNo: MobNo)
    func saveInfo(info: Info)
    
}

protocol WebServiceToInteractor: class {
    
    func responseSuccess(dic: NSDictionary)
    func responseError(error : CustomError)
    func dbFetchSuccess()
    func dbSaveSuccess(mobNo: MobNo)
    func dbInfoFetchSuccess()
    func dbInfoSaveSuccess(info: Info)
    
}

protocol PresenterToRouterProtocol: class {
    // Router
    
    static func createModule() -> UIViewController
    static func MainModule() -> UIViewController
    static func TrxnModule() -> UIViewController

}


extension PresenterOutputProtocol {
    var presenter: PresenterInputProtocol? {
        get {
            presenterObject?.view = self
            self.presenter = presenterObject
            return presenterObject
        }
        set(newValue){
            presenterObject = newValue
        }
    }
}
