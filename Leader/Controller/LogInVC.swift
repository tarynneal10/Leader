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

class LoginVC : UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var handle: AuthStateDidChangeListenerHandle?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    func errorAlert() {
        let alert = UIAlertController(title: "Error", message: "Your information is incorrect", preferredStyle: .alert)
        
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { (UIAlertAction) in
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
        })
        
        alert.addAction(tryAgainAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func logInPressed(_ sender: Any) {
        //Current bug is that if anything is entered in both, it lets you through. Works for blank tho
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
                    
                }
            }
            
        } else {
            errorAlert()
        }

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
