//
//  DetailedViewController.swift
//  TorontoActivities
//
//  Created by Hamza Lakhani on 2016-12-15.
//  Copyright © 2016 Hamza Lakhani. All rights reserved.
//

import UIKit
import MapKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    var selectedFacility : Facility!
    var initialLocation : CLLocation!
    let regionRadius: CLLocationDistance = 150
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set labels + map to values obtained from selected facility
        nameLabel.text = selectedFacility.name
        addressLabel.text = selectedFacility.address + "\n" + selectedFacility.postalCode
        phoneNoLabel.text = selectedFacility.phone
        initialLocation = CLLocation(latitude: Double(selectedFacility.latitude)!, longitude: Double(selectedFacility.longitude)!)
        centerMapOnLocation(location: initialLocation)
//        selectedFacility.title = selectedFacility.name
//        selectedFacility.subtitle = selectedFacility.address
//        selectedFacility.coordinate = CLLocationCoordinate2DMake(Double(selectedFacility.latitude)!, Double(selectedFacility.longitude)!)
//        
//        mapView.addAnnotation(selectedFacility)
        let annotation = Annotation(title: selectedFacility.name, address: selectedFacility.address, coordinate: CLLocationCoordinate2DMake(Double(selectedFacility.latitude)!, Double(selectedFacility.longitude)!))
        
        mapView.addAnnotation(annotation)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
