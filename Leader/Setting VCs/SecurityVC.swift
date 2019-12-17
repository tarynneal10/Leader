//
//  SecurityVC.swift
//  Leader
//
//  Created by Taryn Neal on 9/29/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SecurityVC : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var positionTF: UITextField!
    @IBOutlet weak var chapterTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var db: Firestore!
    var docRef : Query?
    var userDoc : String?
    var userPaidStatus : Bool?
    var userGrade : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        passwordTF.isHidden = true
        passwordTF.isSecureTextEntry = true
        doneButton.isHidden = true
        
        //The code below loads the current member's informastion based on their user UID from when they signed in.
        guard let userID = Auth.auth().currentUser?.uid else { return }
        guard let email = Auth.auth().currentUser?.email else { return }
        docRef = db.collection("members").whereField("user UID", isEqualTo: userID)
        docRef!.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                //Put more error handling here
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    //Sets Fields to data
                    self.nameTF.text = document.get("name") as? String
                    self.chapterTF.text = document.get("chapter") as? String
                    self.positionTF.text = document.get("position") as? String
                    self.emailTF.text = email
                    
                    //Sets data for when changed (Want to incorp in UI eventually)
                    self.userDoc = document.documentID
                    self.userPaidStatus = document.get("paid") as? Bool
                    self.userGrade = document.get("grade") as? Int
                    
                }
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @IBAction func editPressed(_ sender: Any) {
        //Changes to UI
        nameTF.isUserInteractionEnabled = true
        positionTF.isUserInteractionEnabled = true
        chapterTF.isUserInteractionEnabled = true
        emailTF.isUserInteractionEnabled = true
        passwordTF.isUserInteractionEnabled = true
        passwordTF.isHidden = false
        editButton.isHidden = true
        nameTF.textColor = UIColor(named: "Black")
        positionTF.textColor = UIColor(named: "Black")
        chapterTF.textColor = UIColor(named: "Black")
        emailTF.textColor = UIColor(named: "Black")
        passwordTF.textColor = UIColor(named: "Black")
        doneButton.isHidden = false
        
    }
//Updates data
    @IBAction func donePressed(_ sender: Any) {

        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        db.collection("members").document(userDoc!).setData([
            "name": nameTF.text!,
            "chapter": chapterTF.text!,
            "position": positionTF.text!,
            "user UID": userID,
            "paid": userPaidStatus!,
            "grade": userGrade!
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        Auth.auth().currentUser?.updateEmail(to: emailTF.text!) { (error) in
            print("Email not updated")
        }
        Auth.auth().currentUser?.updatePassword(to: passwordTF.text!) { (error) in
            print("Password not updated")
        }
    }
}
