//
//  ProximaBoldLabel.swift
//  GroupProject
//
//  Created by Jordan Hendrickson on 7/2/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import UIKit

class ProximaBoldLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateFontTo(fontName: FontNames.proximaNovaBold)
        setupUI()
    }
    
    func updateFontTo(fontName: String) {
        self.font = UIFont(name: fontName, size: 13)
    }
    
    func setupUI(){
        addCornerRadius()
    }
}
