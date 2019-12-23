//
//  AddCurrentEventVC.swift
//  Leader
//
//  Created by Taryn Neal on 9/16/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddEventVC : UIViewController, UITextFieldDelegate {
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var db: Firestore!
    var userRef : Query?
    var chapterName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        getUser()
   
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func getUser() {
        if Auth.auth().currentUser != nil {
            // User is signed in.
            let userID = Auth.auth().currentUser?.uid
            userRef = db.collection("members").whereField("user UID", isEqualTo: userID!)
            userRef?.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    //Put more error handling here
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let chapter = document.get("chapter") as? String
                        self.chapterName = chapter!
                    }
                }
            }
        } else {
            // No user is signed in.
            print("User not signed in")
        }

    }
    func addToFirestore() {
        
                var ref: DocumentReference? = nil
                ref = db.collection("currentevents").addDocument(data: [
                    "name": titleText.text!,
                    "description": descriptionText.text!,
                    "date": datePicker.date,
                    "chapter": chapterName
                    //Force unwraps bc checked in createEventPressed
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                        
                    }
                }
        
    }
    func errorAlert() {
        let alert = UIAlertController(title: "Error", message: "Please enter all the event information", preferredStyle: .alert)
        
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { (UIAlertAction) in
  
        })
        
        alert.addAction(tryAgainAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func createEventPressed(_ sender: Any) {
        if titleText.text != "", descriptionText.text != ""
        {
            addToFirestore()
            dismiss(animated: true, completion: nil)
          //  dismiss(animated: true, completion: nil)
        } else {
            errorAlert()
        }
    }
    
}
