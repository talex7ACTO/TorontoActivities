//
//  MasterViewController.swift
//  TorontoActivities
//
//  Created by Tomza on 2016-12-15.
//  Copyright © 2016 Tomza. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate{
    @IBOutlet var tableSearch: UITableView!
    
    // MARK: - Properties
    var facilityArray = [Facilites]()
    var filteredfac = [Facilites]()
    var shouldShowSearchResults = false
    let searchController = UISearchController(searchResultsController: nil)
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var results = [Facility]()
    var districts = Set<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchManager = SearchManager()
        searchManager.getJson()
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        //setup of the filter scope
        
        searchController.searchBar.scopeButtonTitles = ["North", "South", "West", "East"]
        tableSearch.tableHeaderView = searchController.searchBar
        
        //configureSearchController()
        
        facilityArray = [
            Facilites(location:"North", name:"Rink 1"),
            Facilites(location:"North", name:"Rink 2"),
            Facilites(location:"South", name:"Rink 3"),
            Facilites(location:"South", name:"Rink 4"),
            Facilites(location:"East", name:"Rink 5"),
            Facilites(location:"East", name:"Rink 6"),
            Facilites(location:"West", name:"Rink 7"),
            Facilites(location:"west", name:"Rink 8"),
        ]
        
        
        //Set of Districts
        for facility in results{
            self.districts.insert(facility["District"])
        }

        
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Facility")
        do {
            self.results = try self.moc.fetch(request) as! [Facility]
        } catch {
            fatalError("Failed to fetch Facilities: \(error)")
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.districts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredfac.count
        }
        else {
            return facilityArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let facilityObject: Facilites
        
        if shouldShowSearchResults {
            facilityObject = filteredfac[indexPath.row]
            
        }else{
            
            facilityObject = facilityArray[indexPath.row]
        }
        cell.nameLabel!.text = facilityObject.name
        cell.nameLocation!.text = facilityObject.location
        return cell
    }
    
    //init a search controller
    /*func configureSearchController() {
     searchController.dimsBackgroundDuringPresentation = true
     //searchController.searchBar.placeholder = "Search here..."
     searchController.searchBar.sizeToFit()
     definesPresentationContext = true
     
     
     searchController.searchBar.scopeButtonTitles = ["North"] //added location as scope
     tableSearch.tableHeaderView = searchController.searchBar
     
     }
     */
    //filtering for the search
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredfac = facilityArray.filter { faculty in
            let locationMatch = (scope == "All") || (faculty.location == scope)
            
            return locationMatch && faculty.name.lowercased().contains(searchText.lowercased())
        }
        
        tableSearch.reloadData()
    }
    
    //delegate and search updating functions
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableSearch.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableSearch.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableSearch.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    func updateSearchResults(for searchController: UISearchController){
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchText: searchController.searchBar.text!, scope: scope)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        
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


