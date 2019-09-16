//
//  LogInVC.swift
//  Leader
//
//  Created by Taryn Neal on 7/28/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
//Current bug is also the when sent here from logout button, still have back button
class LoginVC : UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var handle: AuthStateDidChangeListenerHandle?
    var logInSuccess : Bool?
    var currentDoc : String?
    var db: Firestore!
    var DocRef : Query?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        db = Firestore.firestore()
        logInSuccess = false
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
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
   
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if identifier == "goToTabs" {
            if logInSuccess != true {
                return false
            }
        }
        return true
    }
    @IBAction func logInPressed(_ sender: Any) {
        
        if emailTextField.text != "", passwordTextField.text != ""
        {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
                (user, error) in
                if error != nil {
                    print(error!)
                    self.errorAlert()
                }
                else {
                    //success
                    print("Log In successful")
                    self.logInSuccess = true
                    //self.findMember()
                    self.performSegue(withIdentifier: "goToTabs", sender: UIButton.self)
                }
            }
            
        } else {
            errorAlert()
        }

    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//        super.touchesBegan(touches, with: event)
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        emailTextField.resignFirstResponder()
//        passwordTextField.resignFirstResponder()
//        return true
//    }
    
    func findMember() {
        //The code works here, but the info isn't being passed to the settings page
//        guard let userID = Auth.auth().currentUser?.uid else { return }
//        DocRef = db.collection("members").whereField("user UID", isEqualTo: userID)
//        DocRef?.getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//                //Put more error handling here
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                    self.currentDoc = document.documentID
//                }
//            }
//        }
    }
}

//import UIKit
//import Firebase
//import SVProgressHUD
//
//class LogInViewController: UIViewController {
//
//    //Textfields pre-linked with IBOutlets
//    @IBOutlet var emailTextfield: UITextField!
//    @IBOutlet var passwordTextfield: UITextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//
//    @IBAction func logInPressed(_ sender: AnyObject) {
//        
//        SVProgressHUD.show()
//
//        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
//
//            if error != nil {
//                print(error!)
//            }
//            else {
//                print("Log in successful")
//
//                SVProgressHUD.dismiss()
//
//                self.performSegue(withIdentifier: "goToChat", sender: self)
//            }
//        }
//
//
//    }
//
//
//
//
//}