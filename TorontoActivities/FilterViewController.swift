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
import CoreLocation


class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    //MARK: Properties
    var filters = [Filter]()
    var ageGroupOptions = [String]()
    var typeOptions = [String]()
    var pickerData = [String]()
    var selectedFilters = [String]()


    
    
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var applyFiltersButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var clearFiltersButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        ageGroupOptions = ["Early Child",
                           "Child",
                           "Youth",
                           "Child & Youth",
                           "Adult",
                           "Older Adult"]
        
        typeOptions = ["Hockey & Shinny",
                       "Leisure Skating",
                       "Womens Shinny"]
        
        let ageGroupFilter = Filter(name: "Age Group", options: ageGroupOptions, selectedOption: "")
        
        let typeFilter = Filter(name: "Type", options: typeOptions, selectedOption: "")
        
        filters.append(ageGroupFilter)
        filters.append(typeFilter)
        
        for filter in filters{
            
            selectedFilters.append(filter.selectedOption)
            
        }
    
        filterView.isHidden = true
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        pickerData = filters[indexPath.row].options
        pickerView.reloadAllComponents()

        filterView.isHidden = false
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FilterTableViewCell

        cell.filterName.text = filters[indexPath.row].name
        cell.selectionLabel.text = filters[indexPath.row].selectedOption
        return cell
    }
    
    
    //picker view datasource methods
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerData.count
        
    }
    
    
    //pickerview delgate methods
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return pickerData[row]
    }
    
    @IBAction func searchFilter(_ sender: Any) {
        
        let selectedFilterRow = filterTableView.indexPathForSelectedRow?.row
        
        let selectedOption = pickerData[pickerView.selectedRow(inComponent: 0)]
        
        filters[selectedFilterRow!].selectedOption = selectedOption
        
        selectedFilters[selectedFilterRow!] = selectedOption
        
        filterView.isHidden = true
        filterTableView.reloadData()
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        
        filterView.isHidden = true
        
    }
    //programetivvally applying segue instead of in story board
    @IBAction func applyFiltersButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "filterSegue", sender: self)
        
    }
    

    @IBAction func clearFiltersButton(_ sender: UIButton) {
        
        for i in 0...(filters.count - 1) {
            filters[i].selectedOption = ""
        }
        
        var blankArray = [String]()
        
        for i in 0...(filters.count - 1) {
            blankArray.append(filters[i].selectedOption)
        }
        
        selectedFilters = blankArray
        filterTableView.reloadData()
    }
    
    func createDate(from session: Session) -> Date? {
        // Setup Date Formatter
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "US_en")
        
        // This should match your full Date string..
        formatter.dateFormat = "EEE MMM d h:mma yyyy"
        
        let endTime = session.time.components(separatedBy: " ")[2]
        
        // Get Full string by combining Time with Date
        let fullDate = session.date + " " + endTime + " " + "2017"
        return formatter.date(from: fullDate)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "filterSegue" {
            let sessionsVC = SessionsViewController()
            
            let realm = try! Realm()
            var filteredSessions = realm.objects(Session.self).filter("ANY course.category = 'Skating'")
            
            if selectedFilters[0] != "" {
                let filteredSessionsTemp = filteredSessions.filter("ANY course.ageGroup = %@", selectedFilters[0])
                if selectedFilters[1] != "" {
                    let filteredSessionsTemp2 = filteredSessionsTemp.filter("ANY course.category = %@", selectedFilters[1])
                    filteredSessions = filteredSessionsTemp2
                }
            } else if selectedFilters[1] != "" {
                let filteredSessionsTemp = filteredSessions.filter("ANY course.category = %@", selectedFilters[1])
                filteredSessions = filteredSessionsTemp
                
            }
            
            for session in filteredSessions {
                session.fullDate = createDate(from: session)!
            }
            
            let orderedArray = filteredSessions.sorted {
                return createDate(from: $0)!.timeIntervalSince(createDate(from: $1)!) < 0
            }
            
            sessionsVC.fetchedSessions = orderedArray
            
            
            
        }
    }
}


