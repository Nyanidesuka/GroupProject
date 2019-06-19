//
//  LocationTableViewCell.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/19/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}//END OF TABLE VIEW CELL CLASS
