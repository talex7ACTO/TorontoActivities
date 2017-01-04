//
//  TableViewCell.swift
//  TorontoActivities
//
//  Created by Tomza on 2016-12-15.
//  Copyright © 2016 Tomza. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    // MARK: properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
