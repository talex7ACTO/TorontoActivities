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
            
            if (((f["Categories"] as! String).contains("Skate")) || (f["Categories"] as! String).contains("Hockey")) && (f["District"] as! String) != "Etobicoke York"
            {
                
                
                //Fetching all Facilities
                let facilitiesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Facility")
                let fetchedFacilities : [Facility]
                
                do {
                    fetchedFacilities = try! moc.fetch(facilitiesFetch) as! [Facility]
                } catch {
                    fatalError("Failed to fetch employees: \(error)")
                }
                
                
                //Creating a Facility object
                
                let facility : Facility
                
                //Checking to see if object already exists in database
                for result in fetchedFacilities {
                    
                    //If exists, set Facilitiy object to result (which is duplicate object located in database)
                    if result.locationID == f["LocationID"] as? String{
                        facility = result
                        
                        //If it does not exist, create new Facility managedObject and set all attributes
                    } else {
                        facility = NSEntityDescription.insertNewObject(forEntityName: "Facility", into: moc) as! Facility
                        
                        facility.accessibility = f["Accessible"] as? String
                        facility.name = f["LocationName"] as? String
                        facility.longitude = Float(f["Longitude"]! as! String)!
                        facility.latitude = Float(f["Latitude"]! as! String)!
                        facility.postalCode = f["PostalCode"] as? String
                        facility.address = f["Address"] as? String
                        facility.phone = f["Phone"] as? String
                        facility.locationID = f["LocationID"] as? String
                    }
                }
                
                //Fetching all districts
                let districtsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "District")
                let fetchedDistricts : [District]
                
                do {
                    fetchedDistricts = try! moc.fetch(districtsFetch) as! [District]
                } catch {
                    fatalError("Failed to fetch employees: \(error)")
                }
                
                
                //Checking to see if object exists in database
                for result in fetchedDistricts {
                    
                    //If exists, set object pulled from database to relationship with facility
                    if result.name == f["District"] as? String{
                        facility.district = result
                    } else {
                        
                        //If it does not exist, create a new District managedObject and set attributes and then set relationship with facility
                        let newDistrict = NSEntityDescription.insertNewObject(forEntityName: "District", into: self.moc) as! District
                        newDistrict.name = f["District"] as? String
                        facility.district = newDistrict
                    }
                }
                
                
                let district = NSEntityDescription.insertNewObject(forEntityName: "District", into: self.moc) as! District
                district.name = f["District"] as? String
                facility.district = district
                
                
                
                
                
                
                
                
                let courses = f["Courses"] as! [[String: AnyObject]]
                
                //iterate through each course at a given facility and set attributes and relationship to facility
                for c in courses{
                    let courseFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Course")
                    let fetchedCourses : [Course]
                    
                    do {
                        fetchedCourses = try! moc.fetch(courseFetch) as! [Course]
                    } catch {
                        fatalError("Failed to fetch employees: \(error)")
                    }
                    
                    
                    //Creating a Course object
                    
                    let courseObject : Course
                    
                    //Checking to see if object already exists in database
                    for result in fetchedCourses {
                        
                        //If exists, set Facilitiy object to result (which is duplicate object located in database)
                        if result.courseID == c["CourseID"] as? String{
                            courseObject = result
                            
                            //If it does not exist, create new Facility managedObject and set all attributes
                        } else{
                            let course = NSEntityDescription.insertNewObject(forEntityName: "Course", into: self.moc) as! Course
                            
                            //                    course.ageMax = Int32(c["AgeMax"] as! String)!  sometimes nil look into data
                            //                    course.ageMin = Int32(c["AgeMin"] as! String)!
                            course.category = c["Categories"] as? String
                            course.courseID = c["CourseID"] as? String
                            course.courseName = c["CourseName"] as? String
                            course.facility = facility
                        }
                    
                    
                        
                        
                        let sessions = c["Session"] as! [[String: String]]
                        
                        //Iterate through each session for a given course and set attributes and relationship to facility
                        for s in sessions {
                            let sessionsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Session")
                            let fetchedSessions : [Session]
                            
                            do {
                                fetchedSessions = try! moc.fetch(sessionsFetch) as! [Session]
                            } catch {
                                fatalError("Failed to fetch employees: \(error)")
                            }
                            
                            
                            //Creating a Facility object
                            
                            let sessionObject : Session
                            
                            //Checking to see if object already exists in database
                            for result in fetchedSessions {
                                
                                //If exists, set Facilitiy object to result (which is duplicate object located in database)
                                if ((result.date! == s["Date"]!) && (result.time! == s["Time"]!))
                                        {
                                            
                                            sessionObject = result
                                            
                                            //If it does not exist, create new Facility managedObject and set all attributes
                                    } else {
                                    let session = NSEntityDescription.insertNewObject(forEntityName: "Session", into: self.moc) as! Session
                                    
                                    session.time = s["Time"]!
                                    session.date = s["Date"]!
                                    session.course = course
                                    
                                }
                            }
                        }
                        
                        //Save moc to database
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

