//
//  CustomTextView.swift
//  GroupProject
//
//  Created by Jordan Hendrickson on 6/26/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import UIKit

class CustomTextView: UITextView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI(){
        self.addViewBorderColor()
        self.addCornerRadius()
    }
}
