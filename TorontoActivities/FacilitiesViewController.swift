//
//  FacilitiesViewController.swift
//  TorontoActivities
//
//  Created by Thomas Alexanian on 2016-12-21.
//  Copyright © 2016 Tomza. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class FacilitiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //! makes it say its def there
    var fetchedFacility: Results<Facility>!
    
    var shouldShowSearchResults = false
    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchManager = SearchManager2()
        searchManager.getJSON()
        
        
        
        let realm = try! Realm()
        fetchedFacility = realm.objects(Facility.self)
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableViewData Source Methods
    
    func configureCell(cell: TableViewCell, indexPath: IndexPath) {
//        cell.nameLabel.text = selectedObject.name
//        cell.nameLocation.text = selectedObject.address
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        // Set up the cell
//        configureCell(cell: cell, indexPath: indexPath)
        cell.nameLabel.text = fetchedFacility[indexPath.row].name
        cell.nameLocation.text = fetchedFacility[indexPath.row].address

        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return fetchedFacility.count
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
