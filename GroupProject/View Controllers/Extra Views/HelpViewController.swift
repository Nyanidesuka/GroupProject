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
    
    //MARK: - Outlets
    @IBOutlet weak var selectError: UIButton!
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var aboutJuiceNowTextView: UITextView!
    
    //MARK: - Properties
    private var issue = ""
    
    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
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
    @IBAction func selectErrorTapped(_ sender: UIButton) {
        presentSimpleInputAlert(title: "How can we help?", message: "Select a feedback type, below")
    }
    
    
    
}// END OF HELP CLASS

extension HelpViewController {
    //MARK: - Mail setup
    func configureMailController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["haleyamber0707@gmail.com"])
        mailComposerVC.setSubject("This is a testeroni")
        mailComposerVC.setMessageBody("This is a test message from JuiceNow, the app for REAL juicers.", isHTML: false)
        return mailComposerVC
    }
    
    //MARK: - Alert controller for submitting error/changing button
    func presentSimpleInputAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //Create actions
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let bugAction = UIAlertAction(title: "Bug", style: .default) { (_) in
            self.issue = "Bug"
            DispatchQueue.main.async {
                self.selectError.setTitle("You've found a bug!", for: .normal)
            }
        }
        let requestAction = UIAlertAction(title: "Request", style: .default) { (_) in
            self.issue = "Product request"
            DispatchQueue.main.async {
                self.selectError.setTitle("You've got a request", for: .normal)
            }
        }
        let feedbackAction = UIAlertAction(title: "Feedback", style: .default) { (_) in
            self.issue = "General feedback"
            DispatchQueue.main.async {
                self.selectError.setTitle("You want to share feedback", for: .normal)
            }
        }
        alertController.addAction(bugAction)
        alertController.addAction(requestAction)
        alertController.addAction(feedbackAction)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true)
    }
} // End of extensions
