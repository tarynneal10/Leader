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
import SVProgressHUD

class LoginVC : UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var handle: AuthStateDidChangeListenerHandle?
    var logInSuccess : Bool?
    var db: Firestore!
    var DocRef : Query?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        db = Firestore.firestore()
        logInSuccess = false
        navigationItem.hidesBackButton = true
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
        guard let email = Auth.auth().currentUser?.email else { return }
        emailTextField.text = email
        
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
        
        SVProgressHUD.dismiss()
        
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
        SVProgressHUD.show()
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
                    SVProgressHUD.dismiss()
                    self.logInSuccess = true
                    self.performSegue(withIdentifier: "goToTabs", sender: UIButton.self)
                }
            }
            
        } else {
            errorAlert()
        }

    }

}
