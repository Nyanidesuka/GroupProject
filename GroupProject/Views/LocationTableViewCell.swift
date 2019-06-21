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
    @IBOutlet weak var locationInfo: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Actions
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
    }
    

}//END OF TABLE VIEW CELL CLASS

