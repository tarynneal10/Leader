//
//  YourCompetitiveEvents.swift
//  Leader
//
//  Created by Taryn Neal on 2/22/20.
//  Copyright © 2020 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import MessageUI

class YourCompetitiveEventsVC : UITableViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet var eventsTableView: UITableView!
    
    var db: Firestore!
    var userRef : Query?
    var passedValue = ""
    var userDoc : String?
    var yourEvents : [String] = [""]
    var advisorEmail : String = ""
    var chapterName : String?
        
    override func viewDidLoad() {
            super.viewDidLoad()
            
            db = Firestore.firestore()
            print(passedValue)
            eventsTableView.delegate = self
            eventsTableView.dataSource = self
            
            getUser()
    }

        //Gets user for other queries
        func getUser() {
            guard let userID = Auth.auth().currentUser?.uid else { return }
            userRef = db.collection("members").whereField("user UID", isEqualTo: userID)
            userRef?.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                            //Put more error handling here
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.userDoc = document.documentID
                    self.yourEvents = (document.get("competitive events") as? Array)!
                    self.chapterName = document.get("chapter") as? String
                }
                self.yourEvents.append(self.passedValue)
                print(self.yourEvents)
                self.eventsTableView.reloadData()
                
            }
        }
        }
    
    func updateData() {
        db.collection("members").document(userDoc!).updateData([
                "competitive events" : yourEvents
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
        }
    }
    
    func findAdvisorInfo() {
        
        let advisorRef = db.collection("members").whereField("chapter", isEqualTo: chapterName!).whereField("position", isEqualTo: "Advisor")
        
        advisorRef.getDocuments()
            { (QuerySnapshot, err) in
                if err != nil
                {
                    print("Error getting documents: \(String(describing: err))");
                    //Put like an error pop up or something
                }
                else
                {
                    for document in QuerySnapshot!.documents {
                        self.advisorEmail = (document.get("email") as? String)!
                        print(document.data())
                    }
                    self.sendEmail()
                }
                
        }
        
    }
    func sendEmail() {
        if advisorEmail != "" {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([advisorEmail])
                mail.setMessageBody("<p>My Events: \(yourEvents)</p>", isHTML: true)
                mail.setSubject("Competitive Events")

                present(mail, animated: true)
 
                } else {
                    // show failure alert
            }
        }
        
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yourEvents.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "yourEventsCell", for: indexPath as IndexPath)as! YourEventsCell
        
            cell.eventsLabel.text = yourEvents[indexPath.row]

            return cell
        }
        
    @IBAction func submitPressed(_ sender: Any) {
        updateData()
        findAdvisorInfo()
    }
    
    @IBAction func savePressed(_ sender: Any) {
        updateData()
    }
    
}
class YourEventsCell : UITableViewCell {
    @IBOutlet weak var eventsLabel: UILabel!
}
