//
//  Style Guide.swift
//  GroupProject
//
//  Created by Jordan Hendrickson on 6/21/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import UIKit

extension UIView {
    func addCornerRadius(_ radius: CGFloat = 4){
        self.layer.cornerRadius = radius
    }
    func addAccentBorderColor(width: CGFloat = 1, color: UIColor = UIColor.darkBlueAccent) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    func addLabelBorderColor(width: CGFloat = 1, color: UIColor = UIColor.greenAccent) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    func addViewBorderColor(width: CGFloat = 1, color: UIColor = UIColor.black) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    func addLocationButtonBorderColor(width: CGFloat = 1, color: UIColor = UIColor.lightGray){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
}

extension UIColor {
    static let darkBlueAccent = UIColor(named: "DarkBlueAccent")!
    static let greenAccent = UIColor(named: "GreenAccent")!
    static let lightBlue = UIColor(named: "LightBlue")!
    static let white = UIColor(named: "White")!
}
