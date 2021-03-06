//
//  ChapterSignUp.swift
//  Leader
//
//  Created by Taryn Neal on 9/11/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ChapterSignUp : UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var chapterName: UITextField!
    @IBOutlet weak var advisorName: UITextField!
    @IBOutlet weak var advisorEmail: UITextField!
    @IBOutlet weak var advisorPassword: UITextField!
    @IBOutlet weak var chapterDescription: UITextView!
    
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var checkmarkButton: UIButton!
    
    var agreed : Bool?
    var signUpSuccess : Bool?
    var db: Firestore!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        agreed = false
        signUpSuccess = false
        db = Firestore.firestore()
        setFontColor()
    }
    
    func setFontColor() {
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.white]

        let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.init(red: 0, green: 122, blue: 255)]

        let attributedString1 = NSMutableAttributedString(string:"Agree to Leader's", attributes:attrs1)

        let attributedString2 = NSMutableAttributedString(string:" Terms of Use", attributes:attrs2)

        attributedString1.append(attributedString2)
        termsButton.setAttributedTitle(attributedString1, for: .normal)
    }
    
//MARK: UITextField&View Functions
    
//UITextField return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
//UITextView return
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        chapterDescription.text = textView.text
            
        if text == "\n" {
            textView.resignFirstResponder()
                
            return false
        }
            
        return true
    }
//Error Alert for when fields empty
    func errorAlert() {
        let alert = UIAlertController(title: "Error", message: "Your information is incorrect", preferredStyle: .alert)
        
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { (UIAlertAction) in
            //Here might want to eventually change color of empty fields to red, then change back to black one interacted with
            //            self.emailTextField.text = ""
            //            self.passwordTextField.text = ""
        })
        
        alert.addAction(tryAgainAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
//Stops from just going straight to next tab
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if identifier == "goToTabs" {
            if signUpSuccess != true {
                return false
            }
        }
        return true
    }
    
//MARK: IBAction Functions
    @IBAction func chapterSignUpPressed(_ sender: Any) {
        signUpSuccess = false
        if chapterName.text != "", advisorEmail.text != "", advisorName.text != "", advisorPassword.text != "", chapterDescription.text != "", agreed != false
        {
            Auth.auth().createUser(withEmail: advisorEmail.text!, password: advisorPassword.text!) {
                (user, error) in
                if error != nil {
                    print(error!)
                    self.errorAlert()
                }
                else {
                    //success
                    print("Registration successful")
                    self.signUpSuccess = true
                    self.performSegue(withIdentifier: "goToTabs", sender: UIButton.self)
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    //Adds advisor as member
                    var ref: DocumentReference? = nil
                    ref = self.db.collection("members").addDocument(data: [
                        "name": self.advisorName.text!,
                        "position": "Advisor",
                        "chapter": self.chapterName.text!,
                        "grade": 0,
                        "paid": true,
                        "user UID": userID,
                        "competitive events": [""],
                        "current events": [""]
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }
                    //Adds chapter
                    var chapterRef: DocumentReference? = nil
                    chapterRef = self.db.collection("chapter").addDocument(data: [
                        "name": self.chapterName.text!,
                        "description": self.chapterDescription.text!
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(chapterRef!.documentID)")
                        }
                    }
                }
            }
        }
            else {
            errorAlert()
            }
    }
    
    @IBAction func checkmarkPressed(_ sender: Any) {
        if agreed == false {
            checkmarkButton.setImage(UIImage(named: "Checkmark"), for: .normal)
            agreed = true
        } else {
            checkmarkButton.setImage(UIImage(named: "Nothing"), for: .normal)
            agreed = false
        }
    }
}

