//
//  Course.swift
//  TorontoActivities
//
//  Created by Thomas Alexanian on 2016-12-22.
//  Copyright © 2016 Tomza. All rights reserved.
//


import UIKit
import RealmSwift
import ObjectMapper

class Course: Object, Mappable  {
    
    //Realm syntax
    dynamic var courseID = ""
    dynamic var courseName = ""
//    dynamic var latitude = 0.00
//    dynamic var longitude = 0.00
//    dynamic var locationID = ""
//    dynamic var name = ""
//    dynamic var phone = ""
//    dynamic var postalCode = ""
//    dynamic var district = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        courseID <- map["CourseID"]
        courseName <- map["CourseName"]
        
        
    }
    
}


