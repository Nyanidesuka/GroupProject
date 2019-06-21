//
//  CustomLabel.swift
//  GroupProject
//
//  Created by Jordan Hendrickson on 6/21/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        self.textColor = UIColor.black
//        self.addLabelBorderColor()
//        self.addCornerRadius()
    }
}
