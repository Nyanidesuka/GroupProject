//
//  CustomLocationButton.swift
//  GroupProject
//
//  Created by Jordan Hendrickson on 6/27/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import UIKit

class CustomLocationButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        addLocationButtonBorderColor(width: 1)
       addCornerRadius(20)
    }
}
