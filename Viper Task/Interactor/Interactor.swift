//
//  Interactor.swift
//  Viper Task
//
//  Created by Apple on 16/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

class Interactor {
    var presenter: InteractorToPresenterProtocol?
    var webService : WebServiceProtocol?
    let db = DatabaseHelper()
    
}

extension Interactor : PresenterToInteractorProtocol{
    
    func fetchInfo() {
        webService?.retrieveInfo()
    }
    
    func saveInfo(info: Info) {
        webService?.saveInfo(info: info)
    }
    
    
    func fetchResponse(url: String, params: [String : Any],_ completion: @escaping (_ isSuccess: Bool) -> Void) {
        webService?.retrieve(url: url, params: params, completion)
    }
    
    func fetchDb() {
        webService?.retrieveDb()
    }
    
    func saveDb(mobNo: MobNo) {
        webService?.saveDb(mobNo: mobNo)
    }
    


}

extension Interactor : WebServiceToInteractor {
  
    func dbInfoFetchSuccess() {
        let abc = db.fetch(Info.self)
      
      if abc.count > 0 {
          self.presenter?.dBInfoDataSuccess(info: abc)
      }else {
          self.presenter?.dBdataError()
          
      }
    }
    
    func dbInfoSaveSuccess(info: Info) {
        db.save()
        let abc = db.fetch(Info.self)
       // print("saved and fetched", abc)
        self.presenter?.dBInfoDataSuccess(info: abc)
    }
    
   
    
    func dbFetchSuccess() {
        
         let abc = db.fetch(MobNo.self)
       
       if abc.count > 0 {
           self.presenter?.dBdataSuccess(mobNos: abc)
       }else {
           self.presenter?.dBdataError()
           
       }
        
        
    }
    
    func dbSaveSuccess(mobNo: MobNo) {
        
        db.save()
        let abc = db.fetch(MobNo.self)
       // print("saved and fetched", abc)
        self.presenter?.dBdataSuccess(mobNos: abc)
    }
    
    
    func responseSuccess(dic: NSDictionary) {
        if dic.count > 0 {
            self.presenter?.dataSuccess(dic: dic)
        }
    }
    
    func responseError(error: CustomError) {
         self.presenter?.dataError(error: error)
    }
    


}
