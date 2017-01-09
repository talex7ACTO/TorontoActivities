//
//  Session.swift
//  TorontoActivities
//
//  Created by Hamza Lakhani on 2016-12-22.
//  Copyright © 2016 Tomza. All rights reserved.
//
import UIKit
import RealmSwift
import ObjectMapper

class Session: Object, Mappable  {
    
    //Realm syntax
    dynamic var time = ""
    dynamic var date = ""
    dynamic var facilityName = ""
    dynamic var category = ""
    dynamic var ageGroup = ""
    
    let course = LinkingObjects(fromType: Course.self, property: "sessions")


//    override class func primaryKey() -> String{
//        return "uniqueKey"
//    }
    

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        time <- map["Time"]
        date <- map["Date"]
        facilityName <- map["LocationName"]
        category <- map["Category"]
        ageGroup <- map["AgeGroup"]
        
        
    }
    
}

