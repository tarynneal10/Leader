//
//  SignUpVC.swift
//  Leader
//
//  Created by Taryn Neal on 9/5/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import Firebase

class SignUpVC : UIViewController {
    @IBOutlet weak var positionTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var chapterTF: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var signUpSuccess : Bool?
    var db: Firestore!
    var navControl = NaviagationController()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signUpSuccess = false
        db = Firestore.firestore()
    }
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if identifier == "goToTabs" {
            //Might be able to have it just return false here and oerform segu e in else for auth- not yet tho
            if signUpSuccess != true {
                return false
            }
        }
        return true
    }
    @IBAction func signUpPressed(_ sender: Any) {
        signUpSuccess = false
        if emailTextField.text != "", passwordTextField.text != "", chapterTF.text != "", nameTF.text != "", positionTF.text != ""
        {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {
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
                    var ref: DocumentReference? = nil
                    ref = self.db.collection("members").addDocument(data: [
                        "name": self.nameTF.text!,
                        "position": self.positionTF.text!,
                        "chapter": self.chapterTF.text!,
                        "user UID": userID
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }
                   // print(userID)
                }
            }

            
        } else {
            errorAlert()
        }
        
    }

    func errorAlert() {
        let alert = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
        
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { (UIAlertAction) in
            
        })
        
        alert.addAction(tryAgainAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
