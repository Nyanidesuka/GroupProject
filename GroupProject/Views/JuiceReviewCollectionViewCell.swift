//
//  JuiceReviewCollectionViewCell.swift
//  GroupProject
//
//  Created by Haley Jones on 6/28/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import UIKit

class JuiceReviewCollectionViewCell: UICollectionViewCell {
    //MARK: Outlets
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet var reviewScoreImages: [UIImageView]!
    
    func updateStars(withScore score: Int){
        for i in 0...score - 1{
            reviewScoreImages[i].image = UIImage(named: "likedStar")
        }
    }
}
