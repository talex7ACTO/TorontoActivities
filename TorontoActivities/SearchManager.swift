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
    
    //Properties
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getJson() {
        
        //Getting JSON data
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
            
            //Covert data into JSON array of facilities
            if let array = try? JSONSerialization.jsonObject(with: data, options: []) as! [[String: AnyObject]] {
                
                //Parse through array and populate database on main thread
                DispatchQueue.main.async {
                    self.dataParse(array: array)
                }
            }
        })
        dataTask.resume()
    }
    
    func dataParse(array: [[String: Any]]) {
        for f in array {
            
            //only include facilities with categories containing skate or hockey (and not in Etobicoke York)
            
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
                facility.locationID = f["LocationID"] as? String
                
                let courses = f["Courses"] as! [[String: AnyObject]]
                
                //iterate through each course at a given facility and set attributes and relationship to facility
                for c in courses{
                    
                    let course = NSEntityDescription.insertNewObject(forEntityName: "Course", into: self.moc) as! Course
                    
                    course.ageGroup = c["AgeGroup"] as? String
//                    course.ageMax = Int32(c["AgeMax"] as! String)!  sometimes nil look into data
//                    course.ageMin = Int32(c["AgeMin"] as! String)!
                    course.category = c["Categories"] as? String
                    course.courseID = c["CourseID"] as? String
                    course.courseName = c["CourseName"] as? String
                    course.programName = c["ProgramName"] as? String
                    course.facility = facility
                    
                    
                    //iterate through each session for a given course and set attributes and relationship to facility
                    for s in c["Sessions"] as! [[String: String]] {
                        
                        let session = NSEntityDescription.insertNewObject(forEntityName: "Session", into: self.moc) as! Session
                        
                        session.time = s["Time"]!
                        session.date = s["Date"]!
                        session.course = course
                    }
                }
                
                //save moc to database
                do {
                    try self.moc.save()
                }catch {
                    let error = error
                    print("\(error)")
                }
                
                
            }
        }
        
    }
    
}
