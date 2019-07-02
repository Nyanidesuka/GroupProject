//
//  CustomTableView.swift
//  GroupProject
//
//  Created by Jordan Hendrickson on 6/26/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import UIKit

class CustomTableView: UITableView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        addViewBorderColor(width: 1)
        self.addCornerRadius()
        
    }
}
