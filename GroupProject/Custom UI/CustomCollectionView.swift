//
//  CustomCollectionView.swift
//  GroupProject
//
//  Created by Jordan Hendrickson on 6/21/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import UIKit

class CustomCollectionView: UICollectionView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        self.addCornerRadius()
        self.addViewBorderColor(width: 1)
    }
}
