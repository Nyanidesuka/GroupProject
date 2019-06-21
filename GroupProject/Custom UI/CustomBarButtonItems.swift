//
//  CustomBarButtonItems.swift
//  GroupProject
//
//  Created by Jordan Hendrickson on 6/21/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import UIKit

class CustomBarButtonItems: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        self.backgroundColor = .lightBlue
        self.addCornerRadius()
        self.setTitleColor(.white, for: .normal)
        self.addAccentBorderColor()
    }
}
