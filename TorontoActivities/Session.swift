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
    dynamic var sessionID = ""
    dynamic var courseID = ""
    
    dynamic var fullDate : Date!
    
    let course = LinkingObjects(fromType: Course.self, property: "sessions")


    override class func primaryKey() -> String{
        return "sessionID"
    }

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func createDate(from session: Session) -> Date? {
        // Setup Date Formatter
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "US_en")
        
        // This should match your full Date string..
        formatter.dateFormat = "EEE MMM d h:mma yyyy"
        
        let endTime = session.time.components(separatedBy: " ")[2]
        
        // Get Full string by combining Time with Date
        let fullDate = session.date + " " + endTime + " " + "2017"
        return formatter.date(from: fullDate)
    }
    
       
    func mapping(map: Map) {
        time <- map["Time"]
        date <- map["Date"]
        sessionID <- map["SessionID"]
        courseID <- map["CourseID"]
        
        
    }
    
}

