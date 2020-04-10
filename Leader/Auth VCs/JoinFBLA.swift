//
//  JoinFBLA.swift
//  Leader
//
//  Created by Taryn Neal on 11/15/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import MessageUI
import Firebase
import SVProgressHUD

class JoinFBLAVC : UITableViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate{
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var schoolTF: UITextField!
    @IBOutlet weak var advisorTF: UITextField!
    @IBOutlet weak var gradeTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var termsOfUseButton: UIButton!
    
    var db: Firestore!
    var signUpSuccess : Bool?
    var advisorEmail : String = ""
    var agreed : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        signUpSuccess = false
        agreed = false
        
        nameTF.delegate = self
        schoolTF.delegate = self
        advisorTF.delegate = self
        gradeTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        
        setFontColor()
    }
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if identifier == "goToTabs" {
            if signUpSuccess != true {
                return false
            }
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
             
         return true
     }
    func setFontColor() {
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.white]

        let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.init(red: 0, green: 122, blue: 255)]

        let attributedString1 = NSMutableAttributedString(string:"Agree to Leader's", attributes:attrs1)

        let attributedString2 = NSMutableAttributedString(string:" Terms of Use", attributes:attrs2)

        attributedString1.append(attributedString2)
        termsOfUseButton.setAttributedTitle(attributedString1, for: .normal)
    }
//MARK: Alerts
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
    
    func advisorAlert() {
        let alert = UIAlertController(title: "Error", message: "You entered the advisor name incorrectly", preferredStyle: .alert)
        
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { (UIAlertAction) in })
        
        alert.addAction(tryAgainAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
//MARK: Add user function
    func addUser() {
        if nameTF.text != "", schoolTF.text != "", advisorTF.text != "", gradeTF.text != "", emailTF.text != "", passwordTF.text != "", agreed != false {
                    Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) {
                            (user, error) in
                            if error != nil {
                                print(error!)
                                self.errorAlert()
                            }
                            else {
                                //success
                                print("Registration successful")
                                guard let userID = Auth.auth().currentUser?.uid else { return }
                                //Adds user as new member
                                var ref: DocumentReference? = nil
                                ref = self.db.collection("members").addDocument(data: [
                                    "name": self.nameTF.text!,
                                    "position": "Member",
                                    "chapter": self.schoolTF.text!,
                                    "grade": self.gradeTF.text!,
                                    "paid": false,
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
                                
                            }
                        }
                    } else {
                        errorAlert()
                    }
    }

    
//MARK: Emailing advisor
    
    func findAdvisorInfo() {
        let advisorRef = db.collection("members").whereField("name", isEqualTo: advisorTF.text!)
        advisorRef.getDocuments() { (QuerySnapshot, err) in
                if err != nil {
                    print("Error getting documents: \(String(describing: err))");
                    self.advisorAlert()
                } else {
                    for document in QuerySnapshot!.documents {
                        self.advisorEmail = (document.get("email") as? String)!
                        print(document.data())
                    }
                    SVProgressHUD.dismiss()
                    if self.advisorEmail == "" {
                        self.advisorAlert()
                    } else {
                        self.signUpSuccess = true
                        self.addUser()
                        self.sendEmail()
                    }
                    
                    
                }
        }
    }
    
    func sendEmail() {
  
    if advisorEmail != "" {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([advisorEmail])
            mail.setMessageBody("<p>Why I want to join FBLA:</p>", isHTML: true)
            mail.setSubject("New FBLA Member- \(nameTF.text!), Grade \(gradeTF.text!)")
            present(mail, animated: true)
            
        } else {
            //Maybe?
            //advisorAlert()
        }
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        self.performSegue(withIdentifier: "goToTabs", sender: UIButton.self)
        
    }
    
//MARK: IBAction functions
    
    @IBAction func checkmarkPressed(_ sender: Any) {
        if agreed == false {
            checkmarkButton.setImage(UIImage(named: "Checkmark"), for: .normal)
            agreed = true
        } else {
            checkmarkButton.setImage(UIImage(named: "Nothing"), for: .normal)
            agreed = false
        }
    }
    @IBAction func joinFBLAPressed(_ sender: Any) {
        findAdvisorInfo()
        SVProgressHUD.show()
    }
}
    
