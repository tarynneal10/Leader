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
        // Along with auto layout, these are the keys for enabling variable cell height
        tableView.estimatedRowHeight = 85.0
       // tableView.rowHeight = UITableView.automaticDimension
       }
//    func textViewDidChange(_ textView: UITextView) {
//        UIView.setAnimationsEnabled(false)
//        textView.sizeToFit()
//        self.tableView.beginUpdates()
//        self.tableView.endUpdates()
//        UIView.setAnimationsEnabled(true)
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    // MARK: UITextViewDelegate
    func textViewDidChange(textView: UITextView) {

        // Calculate if the text view will change height, then only force
        // the table to update if it does.  Also disable animations to
        // prevent "jankiness".

        let startHeight = textView.frame.size.height
        let calcHeight = textView.sizeThatFits(textView.frame.size).height

        if startHeight != calcHeight {

            UIView.setAnimationsEnabled(false) // Disable animations
            self.tableView.beginUpdates()
            self.tableView.endUpdates()

            // Might need to insert additional stuff here if scrolls
            // table in an unexpected way.  This scrolls to the bottom
            // of the table. (Though you might need something more
            // complicated if editing in the middle.)

            let scrollTo = self.tableView.contentSize.height - self.tableView.frame.size.height
            self.tableView.setContentOffset(CGPoint(x: 0, y: scrollTo), animated: false)

            UIView.setAnimationsEnabled(true)  // Re-enable animations.
    }
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
        
        return cell
    }
    
    
}
class MinutesCell : UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var minutesTextView: UITextView!
}
