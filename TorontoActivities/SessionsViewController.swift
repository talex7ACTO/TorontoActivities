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

class SessionsViewController: UITableViewController {
    
    //MARK:Properties
    
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
        
        
        
        let course = fetchedSessions[indexPath.row].course.first
//        
//        let facilityName = course?.facility.first?.name
        
        cell.sessionNameLabel.text = fetchedSessions[indexPath.row].date + " - \(fetchedSessions[indexPath.row].time)"
        
        cell.sessionTypeLabel.text = course?.category
        cell.sessionAgeGroupLabel.text = course?.ageGroup

        
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

        return cell
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilterSegue" {
            let filtersVC = segue.destination as! FilterViewController
            let indexPath = tableView.indexPathForSelectedRow!
            //coursesVC.selectedFacility = fetchedCourses[indexPath.row]
        }
    }

    
    @IBAction func sortSwitch(_ sender: Any) {
        
        if sortBySwitch.isEnabled{
            fetchedSessions.sort() { $0.fullDate > $1.fruitName }
        }
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
