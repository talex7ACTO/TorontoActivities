//
//  FacilitiesViewController.swift
//  TorontoActivities
//
//  Created by Thomas Alexanian on 2016-12-21.
//  Copyright © 2016 Tomza. All rights reserved.
//

import UIKit
import CoreData

class FacilitiesViewController: UIViewController {
//NSFetchedResultsControllerDelegate, UITableViewDataSource {

  
    
    @IBOutlet var tableView: UITableView!
    
    
    //Properties
    var fetchedResultsController: NSFetchedResultsController<NSManagedObject>!
    
//    func initializeFetchedResultsController() {
//        let request = NSFetchRequest<NSManagedObject>(entityName: "Facility")
//       // let districtSort = NSSortDescriptor(key: "district", ascending: true)
//        let nameSort = NSSortDescriptor(key: "name", ascending: true)
//        request.sortDescriptors = [nameSort]
//        
//        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.moc, sectionNameKeyPath: "district", cacheName: "rootCache")
//        fetchedResultsController.delegate = self
//        
//        do {
//            try fetchedResultsController.performFetch()
//        } catch {
//            fatalError("Failed to initialize FetchedResultsController: \(error)")
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchManager = SearchManager2()
        searchManager.getJSON()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    //UITableViewData Source Methods
//    
//    func configureCell(cell: TableViewCell, indexPath: IndexPath) {
//        guard let selectedObject = fetchedResultsController.object(at: indexPath) as? Facility else { fatalError("Unexpected Object in FetchedResultsController") }
//        // Populate cell from the NSManagedObject instance
//        cell.nameLabel.text = selectedObject.name
//        cell.nameLocation.text = selectedObject.address
//        
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
//        // Set up the cell
//        configureCell(cell: cell, indexPath: indexPath)
//        return cell
//    }
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return fetchedResultsController.sections!.count
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let sections = fetchedResultsController.sections else {
//            fatalError("No sections in fetchedResultsController")
//        }
//        let sectionInfo = sections[section]
//        return sectionInfo.numberOfObjects
//    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
