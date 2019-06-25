//
//  HelpViewController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit
import MessageUI

class HelpViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    //this isn't done, but i cant get to this viewcontroller yet so i cant test it to move further
    @IBAction func sendErrorTapped(_ sender: UIButton) {
        let mailController = configureMailController()
        if MFMailComposeViewController.canSendMail(){
            print("we can send mail.👔👔👔")
        } else {
            print("we actually cannot send mail.👔👔👔")
        }
//        dismiss(animated: true, completion: nil)
    }
    
    func configureMailController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["haleyamber0707@gmail.com"])
        mailComposerVC.setSubject("This is a testeroni")
        mailComposerVC.setMessageBody("This is a test message from JuiceNow, the app for REAL juicers.", isHTML: false)
        return mailComposerVC
    }
}
