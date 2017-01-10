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


class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    //MARK: Properties
    var filters = [String:[String]]()
    var ageArray = [String]()
    var typeArray = [String]()
    var pickerData = [String]()
    
    
    @IBOutlet weak var filterTableView: UITableView!
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ageArray = ["Early Child",
                    "Child",
                    "Youth",
                    "Child & Youth",
                    "Adult",
                    "Older Adult"]
        
        typeArray = ["Hockey & Shinny",
                     "Leisure Skating",
                     "Womens Shinny"]
        
        filters = ["Age":ageArray,
                   "Type":typeArray]
        
        
        filterView.isHidden = true
    }
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = filterTableView.cellForRow(at: indexPath) as! FilterTableViewCell
        
        pickerData = filters[currentCell.filterName.text!]!
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
        
        var filterNames = [String]()
        for filter in filters.keys {
            filterNames.append(filter)
        }
        
        cell.filterName.text = filterNames[indexPath.row]
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
        
    }
    
}

