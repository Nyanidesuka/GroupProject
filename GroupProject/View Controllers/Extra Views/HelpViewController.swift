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

    @IBOutlet weak var selectError: UIButton!
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
    
<<<<<<< HEAD
    func configureMailController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["haleyamber0707@gmail.com"])
        mailComposerVC.setSubject("This is a testeroni")
        mailComposerVC.setMessageBody("This is a test message from JuiceNow, the app for REAL juicers.", isHTML: false)
        return mailComposerVC
=======
    @IBAction func selectErrorButtonTapped(_ sender: Any) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
>>>>>>> aa96f6f376d710481bc020c689c8c4be04bc5936
    }
}
