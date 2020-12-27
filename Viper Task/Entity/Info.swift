//
//  Info.swift
//  Viper Task
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import CoreData

class Info : NSManagedObject {
    
    @NSManaged var amount : String
    @NSManaged var id : String
    @NSManaged var isCredit : Bool
    @NSManaged var storedNo : String
   
}
