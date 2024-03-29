//
//  HelpViewController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit
import MessageUI

class HelpViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var selectError: UIButton!
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var aboutJuiceNowTextView: UITextView!
    @IBOutlet weak var sendFeedbackButton: UIButton!
    
    //MARK: - Properties
    private var issue = "Feedback for JuiceNow team"
    let appDescription = """
JuiceNow is here for you and your immediate juice needs. If there's a problem with the app, you have a juicy request, or just want to say hello please send us a message with this forum. Providing relevant and up-to-date reviews for our juice-loving community is important to us.

Juice Reviews - JuiceNow is a platform for reviewing individual juices, not only as a record for yourself but also for others. How many times have you arrived at a local juicery and either forgotten what you previously tried or wonder what others thought about a specific drink? We understand and we're here for you.

Locations/Reviews - We've become friends Yelp and their API (developer talk for great juicy info) to simply show locations that have been claimed, reviewed, and exist today.

Search - Finding a juice location near you is easy. Once again, #ThankYouYelp for providing the fuel for our juice fire. Every search, result, and review comes from their platform.

Images - Until our JuiceNow team grows from a few trees to an orchard, we've humbly used free images from the artists at Apple and Flaticon.com


-- Thanks Again & Stay Juicy --
"""
    
    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        feedbackTextView.delegate = self
        updateView()
    }
    
    //MARK: - Actions
    //this isn't done, but i cant get to this viewcontroller yet so i cant test it to move further
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func sendErrorTapped(_ sender: UIButton) {
        guard let feedback = feedbackTextView.text else { return }
        let mailComposeViewController = configureMailController(feedback: feedback)
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
    }
    @IBAction func selectErrorTapped(_ sender: UIButton) {
        presentSimpleInputAlert(title: "How can we help?", message: "Select a feedback type, below")
    }
    
    func updateView() {
        feedbackTextView.layer.borderWidth = 2
        feedbackTextView.layer.cornerRadius = 5
        feedbackTextView.layer.borderColor = UIColor.gray.cgColor
        feedbackTextView.text = "Enter feedback here..."
        feedbackTextView.textColor = UIColor.lightGray
        aboutJuiceNowTextView.text = appDescription
    }
    
}// END OF HELP CLASS

extension HelpViewController {
    //MARK: - Mail setup
    func configureMailController(feedback: String) -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["JuiceNowApp@gmail.com"])
        mailComposerVC.setSubject("Issue 104: Feedback for JuiceNow team")
        mailComposerVC.setMessageBody("This is a test message from JuiceNow, the app for REAL juicers.\nError type: \(self.issue)\nFeedback: \(feedback)", isHTML: false)
        return mailComposerVC
    }
    
    //MARK: - Mail delegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send message at this time", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        sendMailErrorAlert.addAction(dismissAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
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
                self.selectError.setTitleColor(UIColor.black, for: .normal)
            }
        }
        let requestAction = UIAlertAction(title: "Request", style: .default) { (_) in
            self.issue = "Product request"
            DispatchQueue.main.async {
                self.selectError.setTitle("You've got a request", for: .normal)
                self.selectError.setTitleColor(UIColor.black, for: .normal)
            }
        }
        let feedbackAction = UIAlertAction(title: "Feedback", style: .default) { (_) in
            self.issue = "General feedback"
            DispatchQueue.main.async {
                self.selectError.setTitle("You want to share app feedback", for: .normal)
                self.selectError.setTitleColor(UIColor.black, for: .normal)
            }
        }
        alertController.addAction(bugAction)
        alertController.addAction(requestAction)
        alertController.addAction(feedbackAction)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true)
    }
    
    //MARK: - Helper funcs to set up textView editing
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter feedback here..."
            textView.textColor = UIColor.lightGray
        }
    }
    
} // End of extensions
