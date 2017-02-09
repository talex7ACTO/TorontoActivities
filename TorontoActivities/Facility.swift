//
//  Facility.swift
//  TorontoActivities
//
//  Created by Hamza Lakhani on 2016-12-15.
//  Copyright © 2016 Hamza Lakhani. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
import MapKit

class Facility: Object, Mappable  {
    
    //Realm syntax
    dynamic var accessibility = ""
    dynamic var address = ""
    dynamic var latitude : String?
    dynamic var longitude : String?
    dynamic var locationID = ""
    dynamic var name = ""
    dynamic var phone = ""
    dynamic var postalCode = ""
    dynamic var district = ""
    
    var courses = List<Course>()
    
//    var coordinate : CLLocationCoordinate2D
//    var title : String?
//    var subtitle : String?
    
//    let transform = TransformOf<Double, String>(fromJSON: { (value: String?) -> Double? in
//        // transform value from String? to Double?
//        return Double(value!)
//    }, toJSON: { (value: Double?) -> String? in
//        // transform value from Double? to String?
//        if let value = value {
//            return String(value)
//        }
//        return nil
//    })
    
    override class func primaryKey() -> String{
        return "locationID"
    }
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        accessibility <- map["Accessible"]
        address <- map["Address"]
//        latitude <- (map["Latitude"], transform)
//        longitude <- (map["Longitude"], transform)
        latitude <- map["Latitude"]
        longitude <- map["Longitude"]
        name <- map["LocationName"]
        phone <- map["Phone"]
        postalCode <- map["PostalCode"]
        district <- map["District"]
        locationID <- map["LocationID"]
        
        courses <- (map["Courses"], RealmListTransform<Course>())

        
    }
    
}
