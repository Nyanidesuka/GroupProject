//
//  LocationReviewTableViewCell.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/20/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class LocationReviewTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

