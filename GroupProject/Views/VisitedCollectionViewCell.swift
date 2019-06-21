//
//  VisitedCollectionViewCell.swift
//  GroupProject
//
//  Created by Haley Jones on 6/20/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class VisitedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var juiceImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        juiceImageView.layer.cornerRadius = 10
        juiceImageView.clipsToBounds = true
        juiceImageView.layer.borderWidth = 3
        juiceImageView.layer.borderColor = UIColor.white.cgColor
    }
    
}
