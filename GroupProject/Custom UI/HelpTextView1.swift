//
//  HelpTextView1.swift
//  GroupProject
//
//  Created by Jordan Hendrickson on 7/3/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//


import UIKit

class HelpTextView1: UITextView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
}
