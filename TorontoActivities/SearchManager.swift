//
//  SearchManager.swift
//  TorontoActivities
//
//  Created by Tomza on 2016-12-18.
//  Copyright © 2016 Tomza. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SwiftyJSON

class SearchManager {
    
    
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getJson() {
        
        //Getting JSON Data
        let session = URLSession(configuration: .default)
        let url = URL(string: "https://www1.toronto.ca/parks/assets/xml/dropinweek1.json")!
        
        let dataTask = session.dataTask(with: url, completionHandler: { (data, response, err) in
            if let error = err {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("Error: No Data Retrieved")
                return
            }
            
            //Test if data is in correct format by printing each facility name and performing count
            if let array = try? JSONSerialization.jsonObject(with: data, options: []) as! [[String: AnyObject]] {
            
                DispatchQueue.main.async {
                    self.dataParse(array: array)
                }
            }
        })
        dataTask.resume()
    }

    func dataParse(array: [[String: Any]]) {
        for f in array {
            
            //only include facilities with categories containing skate or hockey
            
            if (((f["Categories"] as! String).range(of: "Skate") != nil) || (f["Categories"] as! String).range(of: "Hockey") != nil) && (f["District"] as! String) != "Etobicoke York"{
                
                let facility = NSEntityDescription.insertNewObject(forEntityName: "Facility", into: self.moc) as! Facility
                
                facility.accessibility = f["Accessible"] as? String
                facility.name = f["LocationName"] as? String
                facility.longitude = Float(f["Longitude"]! as! String)!
                facility.latitude = Float(f["Latitude"]! as! String)!
                facility.postalCode = f["PostalCode"] as? String
                facility.address = f["Address"] as? String
                facility.district = f["District"] as? String
                facility.phone = f["Phone"] as? String
                
                let courses = f["Courses"] as! [[String : AnyObject]]
                
                facility.course?.addingObjects(from: courses)
                
                do {
                    try self.moc.save()
                }catch {
                    let error = error
                    print("\(error)")
                }
                //       for c in f["Courses"] as! [AnyObject]{
                
                //      facility.course.addingObjects(from: f["Courses"])
                //}
                //               print("\(facility["LocationName"]!)")
                
            }
        }

    }

}
