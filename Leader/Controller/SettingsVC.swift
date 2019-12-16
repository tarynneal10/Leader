//
//  SettingsViewController.swift
//  Leader
//
//  Created by Taryn Neal on 7/23/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import MessageUI

class SettingsVC : UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    var db: Firestore!
    let logInVC = LoginVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.image = UIImage(named: "Anon")
        db = Firestore.firestore()
        
        //The code below loads the current member's informastion based on their user UID from when they signed in.
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let docRef = db.collection("members").whereField("user UID", isEqualTo: userID)
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                //Put more error handling here
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.nameLabel.text = document.get("name") as? String
                    self.chapterLabel.text = document.get("chapter") as? String
                    self.positionLabel.text = document.get("position") as? String
                }
            }
        }
    }

    @IBAction func bugReportPressed(_ sender: Any) {
        sendEmail()
    }
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["tarynneal10@gmail.com"])
            mail.setMessageBody("<p>Description of Bug:</p>", isHTML: true)
            mail.setSubject("Bug Report")
    
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @IBOutlet weak var testLabel: UILabel!

}

class TabBarController : UITabBarController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesBackButton = true
        
    }
}
class NaviagationController : UINavigationController {
    
}
