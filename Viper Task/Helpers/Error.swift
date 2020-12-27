//
//  Error.swift
//  Viper Task
//
//  Created by Apple on 16/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

protocol CustomErrorProtocol : Error {
    var localizedDescription : String {get set}
}

struct CustomError : CustomErrorProtocol {
    
    var localizedDescription: String
    var statusCode : Int
    
    init(description : String, code : Int){
        self.localizedDescription = description
        self.statusCode = code
    }
}
