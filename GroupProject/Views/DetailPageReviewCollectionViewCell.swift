//
//  DetailPageReviewCollectionViewCell.swift
//  GroupProject
//
//  Created by Haley Jones on 6/30/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import UIKit

class DetailPageReviewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var juiceNameLabel: UILabel!
    @IBOutlet var reviewScoreImages: [UIImageView]!
    func updateStarButtons(withReview review: JuiceReview){
        print("rating: \(review.drinkRating)")
        for image in reviewScoreImages{
            if review.drinkRating - 1 >= image.tag{
                image.image = #imageLiteral(resourceName: "orange slice")
            } else {
                image.image = #imageLiteral(resourceName: "orange slice rank 1")
            }
        }
    }
}
