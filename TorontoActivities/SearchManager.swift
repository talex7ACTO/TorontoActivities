////
////  SearchManager.swift
////  TorontoActivities
////
////  Created by Tomza on 2016-12-18.
////  Copyright © 2016 Tomza. All rights reserved.
////
//
//import Foundation
//import UIKit
//import CoreData
//
//class SearchManager {
//    
//    //Properties
//    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    
//    func getJson() {
//        //Getting JSON data
//        let session = URLSession(configuration: .default)
//        let url = URL(string: "https://www1.toronto.ca/parks/assets/xml/dropinweek1.json")!
//        
//        let dataTask = session.dataTask(with: url, completionHandler: { (data, response, err)  in
//            
//            if let error = err {
//                print("Error: \(error)")
//                return
//            }
//            
//            guard let data = data else {
//                print("Error: No Data Retrieved")
//                return
//            }
//            
//            //Covert data into JSON array of facilities
//            if let array = try? JSONSerialization.jsonObject(with: data, options: []) as! [[String: AnyObject]] {
//                
//                //Parse through array and populate database on main thread
//                DispatchQueue.main.async {
//                    self.dataParse(array: array)
//                }
//            }
//        })
//        dataTask.resume()
//    }
//    
//    
//    
//    private func fetchFacilities()-> [Facility] {
//        //Fetching all Facilities
//        let facilitiesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Facility")
//        return try! moc.fetch(facilitiesFetch) as! [Facility]
//    }
//    
//    private func createFacility(entity: [String: Any])->Facility {
//        let facilityObject = NSEntityDescription.insertNewObject(forEntityName: "Facility", into: moc) as! Facility
//        
//        facilityObject.accessibility = entity["Accessible"] as? String
//        facilityObject.name = entity["LocationName"] as? String
//        facilityObject.longitude = Float(entity["Longitude"]! as! String)!
//        facilityObject.latitude = Float(entity["Latitude"]! as! String)!
//        facilityObject.postalCode = entity["PostalCode"] as? String
//        facilityObject.address = entity["Address"] as? String
//        facilityObject.phone = entity["Phone"] as? String
//        facilityObject.locationID = entity["LocationID"] as? String
//        return facilityObject
//    }
//    
//    func filter(fetchedFacilities: [[String: Any]]) -> [[String: Any]] {
//        var result: [[String: Any]] = []
//        for facility in fetchedFacilities {
//            let facilityInDistrict = facility["District"] as! String
//            let hasSkating = (facility["Categories"] as! String).contains("Skate")
//            let hasHockey = (facility["Categories"] as! String).contains("Hockey")
//            
//            guard facilityInDistrict != "Etobicoke York"  else {
//                continue
//            }
//            
//            guard (hasSkating || hasHockey) else {
//                continue
//            }
//            result.append(facility)
//        }
//        return result
//    }
//    
//    
//    func insertDistrict(with facilityJSON:[String:Any], and facility:Facility) {
//        let newDistrict = NSEntityDescription.insertNewObject(forEntityName: "District", into: self.moc) as! District
//        newDistrict.name = facilityJSON["District"] as? String
//        facility.district = newDistrict
//    }
//    
//    func dataParse(array arrayOfFacilities: [[String: Any]]) {
//        
//        let facilitiesCD = fetchFacilities()
//        let districtsCD = try! moc.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: "District")) as! [District]
//        let courseFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Course")
//        let coursesCD = try! moc.fetch(courseFetch) as! [Course]
//        let filteredFacilitiesJSON = filter(fetchedFacilities: arrayOfFacilities)
//        
//        for facilityJSON in filteredFacilitiesJSON[0...0] {
//            
//            var tempFacility : Facility!
//            
//            
//            
//            //If database is empty, create the facility, district and assosciate them
//            if facilitiesCD.count < 1 {
//                tempFacility = createFacility(entity: facilityJSON)
//                insertDistrict(with: facilityJSON, and: tempFacility)
//                
//            } else {
//                for facilityCD in facilitiesCD {
//                    
//                    //If exists, set Facilitiy object to result (which is duplicate object located in database)
//                    
//                    guard facilityCD.locationID != facilityJSON["LocationID"] as? String else {
//                        continue
//                    }
//                    
//                    tempFacility = createFacility(entity: facilityJSON)
//                    
//                    
//                    //Checking to see if object exists in database
//                    
//                    
//                    for districtCD in districtsCD {
//                        
//                        //If exists, set object pulled from database to relationship with facility
//                        if districtCD.name == facilityJSON["District"] as? String{
//                            tempFacility.district = districtCD
//                        } else {
//                            //If it does not exist, create a new District managedObject and set attributes and then set relationship with facility
//                            insertDistrict(with: facilityJSON, and:tempFacility)
//                        }
//                    }
//                    
//                    //MARK: Courses
//                    
//                    
//                    let coursesJSON = facilityJSON["Courses"] as! [[String: AnyObject]]
//                    
//                    //iterate through each course at a given facility and set attributes and relationship to facility
//
//                    
//                    for courseJSON in coursesJSON{
//                        
//                        //Creating a Course object
//                        
//                        var tempCourse : Course!
//                        
//                        //Checking to see if object already exists in database
//                        for courseCD in coursesCD {
//                            
//                            //If exists, set Course object to result (which is duplicate object located in database)
//                            if courseCD.courseID == courseJSON["CourseID"] as? String{
//                                tempCourse = courseCD
//                                
//                                //If it does not exist, create new Course managedObject and set all attributes
//                            } else{
//                                tempCourse = NSEntityDescription.insertNewObject(forEntityName: "Course", into: self.moc) as! Course
//                                
//                                //                    course.ageMax = Int32(c["AgeMax"] as! String)!  sometimes nil look into data
//                                //                    course.ageMin = Int32(c["AgeMin"] as! String)!
//                                tempCourse.category = courseJSON["Categories"] as? String
//                                tempCourse.courseID = courseJSON["CourseID"] as? String
//                                tempCourse.courseName = courseJSON["CourseName"] as? String
//                                tempCourse.facility = tempFacility
//                            }
//                            
//                            //Fetching all Program Names
//                            let programNameRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProgramName")
//                            let programNamesCD = try! moc.fetch(programNameRequest) as! [ProgramName]
//                            //Checking to see if object exists in database
//                            for programNameCD in programNamesCD {
//                                
//                                //If exists, set object pulled from database to relationship with facility
//                                if programNameCD.name == courseJSON["ProgramName"] as? String{
//                                    tempCourse.programName = programNameCD
//                                } else {
//                                    
//                                    //If it does not exist, create a new District managedObject and set attributes and then set relationship with facility
//                                    let newProgramName = NSEntityDescription.insertNewObject(forEntityName: "ProgramName", into: self.moc) as! ProgramName
//                                    newProgramName.name = courseJSON["ProgramName"] as? String
//                                    tempCourse.programName = newProgramName
//                                }
//                            }
//                            
//                            
//                            //Fetching all AgeGroups
//                            let ageRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Age")
//                            let agesCD = try! moc.fetch(ageRequest) as! [Age]
//                            //Checking to see if object exists in database
//                            for ageCD in agesCD {
//                                
//                                //If exists, set object pulled from database to relationship with facility
//                                if ageCD.ageGroup == courseJSON["AgeGroup"] as? String{
//                                    tempCourse.age = ageCD
//                                } else {
//                                    
//                                    //If it does not exist, create a new District managedObject and set attributes and then set relationship with facility
//                                    let newAge = NSEntityDescription.insertNewObject(forEntityName: "Age", into: self.moc) as! Age
//                                    newAge.ageGroup = courseJSON["AgeGroup"] as? String
//                                    newAge.ageMax = (courseJSON["AgeMax"] as? Int32)!
//                                    newAge.ageMin = (courseJSON["AgeMin"] as? Int32)!
//                                    tempCourse.age = newAge
//                                }
//                            }
//                            
//                            
//                            let sessionsJSON = courseJSON["Sessions"] as! [[String: String]]
//                            
//                            //Iterate through each session for a given course and set attributes and relationship to facility
//                            for sessionJSON in sessionsJSON {
//                                let sessionsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Session")
//                                let sessionsCD = try! moc.fetch(sessionsFetch) as! [Session]
//                                //Creating a Facility object
//                                
//                                var tempSession : Session!
//                                
//                                //Checking to see if object already exists in database
//                                for sessionCD in sessionsCD {
//                                    
//                                    //If exists, set Facilitiy object to result (which is duplicate object located in database)
//                                    if ((sessionCD.date! == sessionJSON["Date"]!) && (sessionCD.time! == sessionJSON["Time"]!))
//                                    {
//                                        tempSession = sessionCD
//                                        
//                                        //If it does not exist, create new Facility managedObject and set all attributes
//                                    } else {
//                                        tempSession = NSEntityDescription.insertNewObject(forEntityName: "Session", into: self.moc) as! Session
//                                        tempSession.time = sessionJSON["Time"]!
//                                        tempSession.date = sessionJSON["Date"]!
//                                        tempSession.course = tempCourse
//                                    }
//                                }
//                            }
//                            
//                        }
//                    }
//                    
//                }
//            }
//            
//        
//            
//        }
//        //Save moc to database
//        do {
//            try self.moc.save()
//        }catch {
//            let error = error
//            print("\(error)")
//        }
//    }
//}
//
