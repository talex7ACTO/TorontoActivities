//
//  SessionsViewController.swift
//  TorontoActivities
//
//  Created by Hamza Lakhani on 2017-01-04.
//  Copyright © 2017 Tomza. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import MapKit
import CoreLocation

class SessionsViewController: UITableViewController,MKMapViewDelegate  {
    
    //MARK:Properties
    var locationManager = CLLocationManager()

    
    
    var fetchedSessions: [Session]!
    var fetchedCourses: Results<Course>! // added for test
    var sessionArray = List<Session>()
    
    @IBOutlet var sessionTableView: UITableView!
    @IBOutlet var sortBySwitch: UIBarButtonItem!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let searchManager = SearchManager2()
        //        searchManager.getJSON()
        
        //fetching all sessions from database
//        if fetchedSessions == nil {
//            let realm = try! Realm()
//            fetchedSessions = realm.objects(Session.self).filter("ANY course.category = 'Skating'")
//        }
        
        
        sessionTableView.reloadData()
        
//        //testing links
//        var i = 1
//        for session in fetchedSessions {
//            
//            print("\((session.course.first?.facility.count)!) -  \(i)")
//            i += 1
//        }
//        


        
    }
    func configureCell(cell: SessionViewCell, indexPath: IndexPath) {
        
        
        let date = fetchedSessions[indexPath.row].fullDate
        let course = fetchedSessions[indexPath.row].course.first
        let facility = course?.facility.first
//        
//        let facilityName = course?.facility.first?.name
        
        cell.sessionNameLabel.text = fetchedSessions[indexPath.row].date + " - \(fetchedSessions[indexPath.row].time)"
        
        cell.sessionTypeLabel.text = course?.programName
        cell.sessionAgeGroupLabel.text = course?.ageGroup
        
        
        if let label = cell.timeLabel {
            label.text = stringFromTimeInterval(interval: (date?.timeIntervalSinceNow)!)
        }
        //ditance label
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedSessions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SessionViewCell

        configureCell(cell: cell, indexPath: indexPath)
        
        cell.facilitiesButton.tag = indexPath.row
        cell.facilitiesButton.addTarget(self, action: #selector(SessionsViewController.buttonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        return cell
    }
    
    
    @IBAction func buttonTapped(_ sender:UIButton!){
        self.performSegue(withIdentifier: "facilitySegue", sender: sender)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "facilitySegue" {
            if let destination = segue.destination as? DetailedViewController {
                
                if let button:UIButton = sender as! UIButton? {
                    destination.selectedFacility = fetchedSessions[button.tag].course[0].facility[0]
                }
            }
        }
    }

    
//    @IBAction func sortSwitch(_ sender: Any) {
//        
//        if sortBySwitch.isEnabled{
//            fetchedSessions.sort() { $0.fullDate > $1.fruitName }
//        }
//    }
//    
    
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let time = Int(interval)
        
        let minutes = (String(format: "%02d", ((time / 60) % 60)))
        let hours = (time / 3600)
        let dateString = "\(hours):\(minutes) \nTime Left"
        
        return dateString
    }
    
    func distanceBetween() {
        
        let currentLocation = CLLocation()
        let currentLat = self.locationManager.location!.coordinate.latitude
        let currentLong = self.locationManager.location!.coordinate.longitude
        
        
        var myLocation = CLLocation(latitude: currentLat, longitude: currentLong)
        let dVC = DetailedViewController()
        
        let facilityLocation = dVC.initialLocation
        let Initialdistance = myLocation.distance(from: facilityLocation!)
//        let shop1 = coffeeShop(location: distance1)!
        
    }

}
