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
        for i in 1...4 {
//            Alamofire.request("https://www1.toronto.ca/parks/assets/xml/dropinweek\(i).json", method: .get).responseArray { (response: DataResponse<[Facility]>) in
                Alamofire.request("https://www1.toronto.ca/parks/assets/xml/dropinweek\(i).json", method: .get).responseJSON{ (response: DataResponse<Any>) in

                guard let facilities = response.result.value else { return }
                for f in facilities as! [AnyObject] {
                    for c in f["Courses"] as! [AnyObject]{
                        for s in c["Sessions"] as! [AnyObject]{
                            s["ID"] = "\(s["Date"])\(s["Time"])\(c["CourseID"])"
                        }
                    }
                }
                let realm = try! Realm()
                try! realm.write {

                    realm.add(facilities, update: true)
                }
            
            }
            
        }
    }
}
