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
//        for i in 1...4 {
            Alamofire.request("https://toronto-activities.herokuapp.com/activities/1", method: .get).responseArray { (response: DataResponse<[Facility]>) in
                guard let facilities = response.result.value else { return }
                let realm = try! Realm()
                try! realm.write {

                    realm.add(facilities, update: true)
                }
            
//            }
            
        }
    }
}
