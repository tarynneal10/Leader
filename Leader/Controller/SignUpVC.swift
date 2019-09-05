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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signUpPressed(_ sender: Any) {
        func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
            
            if identifier == "goToTabs" {
                //Does this account for only missing one?
                if emailTextField.text?.isEmpty == true, passwordTextField.text?.isEmpty == true {
                    print("*** NOPE, segue wont occur")
                    errorAlert()
                    return false
                }
                else {
                    print("*** YEP, segue will occur")
                    Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {
                        (user, error) in
                        if error != nil {
                            print(error!)
                            self.errorAlert()
                        }
                        else {
                            //success
                            print("Registration successful")
                            
                            self.performSegue(withIdentifier: "goToTabs", sender: self)
                        }
                    }
                }
            }
            
            // by default, transition
            return true
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
