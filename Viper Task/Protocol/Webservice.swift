//
//  WebServices.swift
//  Viper Task
//
//  Created by Apple on 16/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Alamofire

class Webservice {
    
    var interactor: WebServiceToInteractor?
    let db = DatabaseHelper()
}

extension Webservice : WebServiceProtocol {
    func retrieve(url: String, params: [String : Any], _ completion: @escaping (Bool) -> Void) {
        
        
        AF.request(url, parameters: params, headers: ["X-Requested-With" : "XMLHttpRequest", "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY3NmViNTc5NmNmY2Q2N2E5NTU4OGMwMDRhOTY2NDAzNGQyNzc0MjQ1MWIwZTVjNmRjMzdmZDY0YjhlNTMyYWE2MDcyZWE2YmJiMGU5NzJkIn0.eyJhdWQiOiIyIiwianRpIjoiNjc2ZWI1Nzk2Y2ZjZDY3YTk1NTg4YzAwNGE5NjY0MDM0ZDI3NzQyNDUxYjBlNWM2ZGMzN2ZkNjRiOGU1MzJhYTYwNzJlYTZiYmIwZTk3MmQiLCJpYXQiOjE2MDU1MzM5MDksIm5iZiI6MTYwNTUzMzkwOSwiZXhwIjoxNjM3MDY5OTA5LCJzdWIiOiIzMyIsInNjb3BlcyI6W119.Mg25mBFF_9OGhOOm6yT3G8O48TfuCLZVAjwCZ1DjfNJrgw6l2o2N7KG9c1f4Vt6hiFqleUqBuLM0rKgLVHLt6mthc3Hmf4N8gXTBWAAvzHa2-2eLvw-_hgtFFScgk3m0HClH24NcGNxifypJbu4Igq6JTdVLyDPJpOQFa55UfeKGY8u2vCMAAdJgniSRYn_L0J2b568k4scnmTHXk5XAPjOLJPQrmha3HGGCfx8sFpZtDsovAfPgzAFW0zcv-TuoQzuAQAGfIbR2M_bGOyBOH9kJdmTkM9D1jfsEiPpyHP0MIyhMPHx4LMy7gcbIYIGKeXX3rXJO-aJCXDZG_0_QrRyjlYqyX1FOg2a-YN7Js6lQpzZ7NveIaVEtUv-TNKTO2LIkSCDmD2__SC4u65tquPZppjXhcFA5bDiYeqb0yfVy2E38mj45eR5A3aJrhSyfY0FY-uNcP0Y72OV2lQJxjx3XJtMdqpjFgI03B1wnmhLKCLgHrqiqOsoBm1-LQyg0yzX75NrPMq5_N66AR-2U-UuZYQfSv2Degu2unxIgGsfYErcn4qeR3MbXOwCH0M_UCyvmD2hdSQp5QwY6ohJPIUjTrGBtQ11w3X2r-E6tHLJQtwylRoOI2SxC5uSK6qOA-LAZ2ROzQ1gSuMUKvUWx5C-KJSh_2IuV9enmsDQub5Y","Content-Type" : "application/json"]).responseJSON { (res) in
            
            switch res.result {
                
            case .success(let val):
                print("valll", res)
                self.interactor?.responseSuccess(dic: val as! NSDictionary)
                completion(true)
            case .failure(_):
                print("err", LocalizedError.self)
                completion(false)
            }
            
        }
    }
    
    func retrieveInfo() {
        interactor?.dbInfoFetchSuccess()
    }
    
    func saveInfo(info: Info) {
        interactor?.dbInfoSaveSuccess(info: info)
    }

    func retrieveDb() {
        self.interactor?.dbFetchSuccess()
    }
       
    func saveDb(mobNo: MobNo) {
        
        self.interactor?.dbSaveSuccess(mobNo: mobNo)
    }
    

}
