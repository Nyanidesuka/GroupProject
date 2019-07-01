//
//  CustomSearchBar.swift
//  GroupProject
//
//  Created by Jordan Hendrickson on 6/27/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexiblespace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done
            , target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([flexiblespace, doneButton], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func dismissKeyboard() {
        self.resignFirstResponder()
    }
    
    func setupUI(){
        addCornerRadius(3)
        addViewBorderColor()
    }
}
