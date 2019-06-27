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
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var juiceNowRating: UILabel!
    @IBOutlet weak var openOrClosed: UILabel!
    
    var businessReference: Business?

    
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
        //nice, its already here. Ok.
        guard let business = businessReference else {return}
        if business.isFavorite == true{
            favoriteButton.setImage(UIImage(named: "unlikedHeart"), for: .normal)
            business.isFavorite = false
            guard let targetIndex = UserController.shared.currentUser?.likedBusinesses.firstIndex(where: {business.businessID == $0.businessID}) else {return}
            UserController.shared.currentUser?.likedBusinesses.remove(at: targetIndex)
        } else {
            favoriteButton.setImage(UIImage(named: "likedHeart"), for: .normal)
            business.isFavorite = true
            UserController.shared.currentUser?.likedBusinesses.append(business)
        }
        guard let user = UserController.shared.currentUser else {return}
        let userDict = UserController.shared.createDictionary(fromUser: user)
        UserController.shared.saveUserDocument(data: userDict) { (success) in
            print("tried so save the doc, and what happened was: \(success)")
        }
    }
}//END OF TABLE VIEW CELL CLASS

