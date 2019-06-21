//
//  CustomCollectionViewView.swift
//  GroupProject
//
//  Created by Jordan Hendrickson on 6/21/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import UIKit

class CustomCollectionViewView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        self.addCornerRadius(20)
        addAccentBorderColor(width: 5)
        
    }
}
