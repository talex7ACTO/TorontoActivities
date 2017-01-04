//
//  CoursesViewController.swift
//  TorontoActivities
//
//  Created by Hamza Lakhani on 2017-01-04.
//  Copyright © 2017 Tomza. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift


class CoursesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    //MARK: Properties
    
    var fetchedCourses: Results<Course>!
    var filters = [Filter]()


    @IBOutlet weak var courseTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        filters = [Filter(name:"Age"),
                   Filter(name:"Location"),
                   Filter(name:"Time/Date"),
                   Filter(name:"Skate")]
        
        

    }
    // MARK: - Table View
 func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FilterTableViewCell
        
        let filter = filters[indexPath.row]
        cell.filterName!.text = filter.name
        return cell
    }



}

