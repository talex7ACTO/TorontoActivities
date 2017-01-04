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
    var filteredFacility: Results<Facility>!
    
    var shouldShowSearchResults = false
    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self
//        definesPresentationContext = true
//        searchController.dimsBackgroundDuringPresentation = false
//        tableView.tableHeaderView = searchController.searchBar


        //pulling data from net to update database
        let searchManager = SearchManager2()
        searchManager.getJSON()
        
        //fetching all facilities from database
        let realm = try! Realm()
        fetchedFacility = realm.objects(Facility.self)
        tableView.reloadData()
        
        let coursesMatch = realm.objects(Course.self).filter("ANY facility.locationID == '1053'")
        print(coursesMatch.count)
        print(coursesMatch)
        
        
        
        // Do any additional setup after loading the view.
    }
    //filtering for the search
//    func filterContentForSearchText(searchText: String, scope: String = "All") {
//        filteredFacility = fetchedFacility.filter ({( facility : Facility) -> Bool in
//            return facility.name.lowercased().contains(searchText.lowercased())
//        })
//        tableView.reloadData()
//    }
    
    //UITableViewData Source Methods

    
    func configureCell(cell: TableViewCell, indexPath: IndexPath) {
        
        cell.nameLabel.text = fetchedFacility[indexPath.row].name
        cell.locationLabel.text = fetchedFacility[indexPath.row].address
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        // Set up the cell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return fetchedFacility.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailedSegue" {
            let detailedVC = segue.destination as! DetailedViewController
            let indexPath = tableView.indexPathForSelectedRow!
            detailedVC.selectedFacility = fetchedFacility[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailedSegue", sender: self)
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

//extension FacilitiesViewController: UISearchBarDelegate {
//    // MARK: - UISearchBar Delegate
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        filterContentForSearchText(searchText: searchController.searchBar.text!)
//    }
//}
//
//extension FacilitiesViewController: UISearchResultsUpdating {
//    // MARK: - UISearchResultsUpdating Delegate
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchText: searchController.searchBar.text!)
//
//    }
//}

