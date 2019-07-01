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
        switch review.drinkRating{
        case 1:
            reviewScoreImages[0].image = #imageLiteral(resourceName: "orange slice")
            reviewScoreImages[1].image = #imageLiteral(resourceName: "orange slice rank 1")
            reviewScoreImages[2].image = #imageLiteral(resourceName: "orange slice rank 1")
            reviewScoreImages[3].image = #imageLiteral(resourceName: "orange slice rank 1")
            reviewScoreImages[4].image = #imageLiteral(resourceName: "orange slice rank 1")
        case 2:
            reviewScoreImages[0].image = #imageLiteral(resourceName: "orange slice")
            reviewScoreImages[1].image = #imageLiteral(resourceName: "orange slice")
            reviewScoreImages[2].image = #imageLiteral(resourceName: "orange slice rank 1")
            reviewScoreImages[3].image = #imageLiteral(resourceName: "orange slice rank 1")
            reviewScoreImages[4].image = #imageLiteral(resourceName: "orange slice rank 1")
        case 3:
            reviewScoreImages[0].image = #imageLiteral(resourceName: "orange slice")
            reviewScoreImages[1].image = #imageLiteral(resourceName: "orange slice")
            reviewScoreImages[2].image = #imageLiteral(resourceName: "orange slice")
            reviewScoreImages[3].image = #imageLiteral(resourceName: "orange slice rank 1")
            reviewScoreImages[4].image = #imageLiteral(resourceName: "orange slice rank 1")
        case 4:
            reviewScoreImages[0].image = #imageLiteral(resourceName: "orange slice")
            reviewScoreImages[1].image = #imageLiteral(resourceName: "orange slice")
            reviewScoreImages[2].image = #imageLiteral(resourceName: "orange slice")
            reviewScoreImages[3].image = #imageLiteral(resourceName: "orange slice")
            reviewScoreImages[4].image = #imageLiteral(resourceName: "orange slice rank 1")
        case 5:
            reviewScoreImages[0].image = #imageLiteral(resourceName: "orange slice")
            reviewScoreImages[1].image = #imageLiteral(resourceName: "orange slice")
            reviewScoreImages[2].image = #imageLiteral(resourceName: "orange slice")
            reviewScoreImages[3].image = #imageLiteral(resourceName: "orange slice")
            reviewScoreImages[4].image = #imageLiteral(resourceName: "orange slice")
        default:
            reviewScoreImages[0].image = #imageLiteral(resourceName: "orange slice rank 1")
            reviewScoreImages[1].image = #imageLiteral(resourceName: "orange slice rank 1")
            reviewScoreImages[2].image = #imageLiteral(resourceName: "orange slice rank 1")
            reviewScoreImages[3].image = #imageLiteral(resourceName: "orange slice rank 1")
            reviewScoreImages[4].image = #imageLiteral(resourceName: "orange slice rank 1")
        }
    }
    
    
}
