//
//  MeetingMinutesVC.swift
//  Leader
//
//  Created by Taryn Neal on 10/20/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class MeetingMinutesVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    var db: Firestore!
    var userRef : Query?
    var list = ["Call to Order","Minutes","Officer Reports","Committee Reports","Unfinished Business","New Business","Annoucements","Adjournment"]
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
        db = Firestore.firestore()
        setTitle()
       }
    
    func setTitle() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        userRef = db.collection("members").whereField("user UID", isEqualTo: userID)
        userRef?.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                //Put more error handling here
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let chapter = document.get("chapter") as? String
                    self.titleLabel.text = "\(chapter!) FBLA Local Chapter Regular Meeting Minutes"
                    //Should probs put in smth for if they don't have chapter
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "minutesCell", for: indexPath as IndexPath) as! MinutesCell
        cell.label.text = list[indexPath.row]
        cell.textView.text = ""
        return cell
    }
    
    
}
class MinutesCell : UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
}
