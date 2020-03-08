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
    let list = ["Call to Order","Minutes","Officer Reports","Committee Reports", "Unfinished Business","New Business","Annoucements","Adjournment"]
    var passedValues = [""]
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
        db = Firestore.firestore()
        setTitle()
        tableView.estimatedRowHeight = 40.0
        tableView.separatorStyle = .none
        //idk why but value isn't passing
        print(passedValues)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
        cell.textChanged {[weak tableView] (newText: String) in
            DispatchQueue.main.async {
                tableView?.beginUpdates()
                tableView?.endUpdates()
            }
        }
        return cell
    }
    @IBAction func savePressed(_ sender: Any) {
        //Getting text view values
        var values = [String:String?]()
        for (index, value) in list.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                guard let cell = tableView.cellForRow(at: indexPath) as? MinutesCell else{ return }
                if let text = cell.minutesTextView.text, !text.isEmpty {
                    values[value] = text
                }
        }
        
        //Adding to firebase
        self.db.collection("minutes").addDocument(data: [
            "minutes": values,
            "attendees": passedValues
            
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added")
            }
        }
        
    }
    
}
class MinutesCell : UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var minutesTextView: UITextView!
    
    var textChanged: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        minutesTextView.delegate = self
    }
    //UITextView return
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        minutesTextView.text = textView.text
            
        if text == "\n" {
            textView.resignFirstResponder()
                
            return false
        }
            
        return true
    }
    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
    
}
