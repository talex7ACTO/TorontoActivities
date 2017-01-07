//
//  FilterViewController.swift
//  TorontoActivities
//
//  Created by Hamza Lakhani on 2017-01-04.
//  Copyright © 2017 Tomza. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class FilterViewController: UITableViewController {
    
    //MARK:Properties
    var fetchedCourses: Results<Course>!
    
    @IBOutlet var courseTableView: UITableView!
    
    @IBOutlet weak var filterButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchManager = SearchManager2()
        searchManager.getJSON()
        
        //fetching all facilities from database
        let realm = try! Realm()
        fetchedCourses = realm.objects(Course.self)
        courseTableView.reloadData()
        //need to understand this-should be using course or facility
        let sessionMatch = realm.objects(Session.self).filter
        print(sessionMatch)
    }
    func configureCell(cell: SessionViewCell, indexPath: IndexPath) {
        
        cell.sessionName.text = fetchedCourses[indexPath.row].courseName
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedCourses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SessionViewCell

        configureCell(cell: cell, indexPath: indexPath)

        return cell
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilterSegue" {
            let coursesVC = segue.destination as! CoursesViewController
            let indexPath = tableView.indexPathForSelectedRow!
            //coursesVC.selectedFacility = fetchedCourses[indexPath.row]
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
