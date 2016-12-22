//
//  SearchManager2.swift
//  TorontoActivities
//
//  Created by Thomas Alexanian on 2016-12-22.
//  Copyright © 2016 Tomza. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import AlamofireObjectMapper

class SearchManager2: NSObject {
    
    func getJSON() {
        Alamofire.request("https://www1.toronto.ca/parks/assets/xml/dropinweek1.json", method: .get).responseArray { (response: DataResponse<[Facility]>) in
            guard let facilities = response.result.value else { return }
            let realm = try! Realm()
            try! realm.write {
                realm.add(facilities, update: true)            }
            
            let facilitiesMatch = realm.objects(Facility.self).filter("ANY courses.courseID == '4817569'")
            print(facilitiesMatch)
        }
    }
}
