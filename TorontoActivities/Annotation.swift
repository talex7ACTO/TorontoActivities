//
//  Annotation.swift
//  TorontoActivities
//
//  Created by Thomas Alexanian on 2017-01-04.
//  Copyright © 2017 Tomza. All rights reserved.
//

import UIKit
import MapKit

class Annotation: NSObject, MKAnnotation {
    
    let coordinate : CLLocationCoordinate2D
    let title : String?
    let subtitle : String?
    
    
    init(title: String, address: String, coordinate: CLLocationCoordinate2D) {
        self.title =  title
        self.subtitle = address
        self.coordinate = coordinate
        
        super.init()
    }
}

