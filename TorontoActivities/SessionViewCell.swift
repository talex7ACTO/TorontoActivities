//
//  SessionViewCell.swift
//  TorontoActivities
//
//  Created by Hamza Lakhani on 2017-01-06.
//  Copyright © 2017 Tomza. All rights reserved.
//

import UIKit

class SessionViewCell: UITableViewCell {

    @IBOutlet weak var sessionNameLabel: UILabel!
    
    @IBOutlet var directionsButton: UIButton!
    @IBOutlet var sessionTypeLabel: UILabel!
    @IBOutlet var facilitiesButton: UIButton!
    @IBOutlet var sessionAgeGroupLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func goToFacilities(_ sender: Any) {
    }
    @IBAction func getDirection(_ sender: Any) {
    }

}
