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
    var addingSuccess : Bool?
        
    override func viewDidLoad() {
            super.viewDidLoad()
            db = Firestore.firestore()
            addingSuccess = false
            
            eventsTableView.delegate = self
            eventsTableView.dataSource = self
            
            getUser()
    }

    
//MARK: Retrieving from cloud
        //Pops up error for if already added event
        func errorAlert() {
            let alert = UIAlertController(title: "Error", message: "You have already added this event", preferredStyle: .alert)
            
            let continueAction = UIAlertAction(title: "Continue", style: .default, handler: { (UIAlertAction) in })
            
            alert.addAction(continueAction)
            self.present(alert, animated: true, completion: nil)
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
                //Checking array values
                self.yourEvents.append(self.passedValue)
//                if self.allUnequal(array: self.yourEvents) == false {
//                    self.errorAlert()
//                    
//                }
            
                print(self.yourEvents)
                self.eventsTableView.reloadData()
                
            }
        }
        }
    
    func allUnequal<T : Equatable>(array : [T]) -> Bool {
        if let firstElem = array.first {
            return !array.dropFirst().contains { $0 == firstElem }
        }
        return true
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

    
//MARK: Table View Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yourEvents.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "yourEventsCell", for: indexPath as IndexPath)as! YourEventsCell
        
            cell.eventsLabel.text = yourEvents[indexPath.row]

            return cell
        }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            self.yourEvents.remove(at: indexPath.row)
            self.eventsTableView.reloadData()

        })

        return [deleteAction]
    }

//MARK: Email & Segue Stuff
    //DOuble check if this is right segue
       override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
           if identifier == "goToHome" {
               if addingSuccess != true {
                   return false
               }
           }
           return true
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
           addingSuccess = true
           performSegue(withIdentifier: "goToHome", sender: UIButton.self)
       }
    
//MARK: IBAction Functions
    
    @IBAction func submitPressed(_ sender: Any) {
        updateData()
        findAdvisorInfo()
    }
    
    @IBAction func savePressed(_ sender: Any) {
        updateData()
    }
    
    
}

//MARK: YourEventsCell Class

class YourEventsCell : UITableViewCell {
    @IBOutlet weak var eventsLabel: UILabel!
}
