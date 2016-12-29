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
    dynamic var ageMax = 0
    dynamic var ageMin = 0
    dynamic var ageGroup = ""
    dynamic var programName = ""
    dynamic var category = ""
    let facility = LinkingObjects(fromType: Facility.self, property: "courses")

    
    var sessions = List<Session>()
    override class func primaryKey() -> String{
        return "courseID"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        courseID <- map["CourseID"]
        courseName <- map["CourseName"]
        ageMax <- map["AgeMax"]
        ageMin <- map["AgeMin"]
        ageGroup <- map["AgeGroup"]
        programName <- map ["ProgramName"]
        category <- map["Category"]
        
        sessions <- (map["Sessions"], RealmListTransform<Session>())
    }
    
}


