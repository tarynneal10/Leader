//
//  LogInVC.swift
//  Leader
//
//  Created by Taryn Neal on 7/28/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
//import RealmSwift
//import Realm

class LoginVC : UIViewController {
//    override func viewWillAppear(_ animated: Bool) {
//
//    }
    
//let realm = try! Realm()
//let testChapter = Chapter()
    
    @IBAction func logInPressed(_ sender: Any) {
        // for swift 2.0 Xcode 7
       // print(Realm.Configuration.defaultConfiguration.fileURL!)
        //testChapter.name = "Marysville Getchell"
//        try! realm.write  {
//            //realm.add(testChapter)
//           // realm.delete(testChapter)
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
