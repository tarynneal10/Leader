//
//  CurrentEventsVC.swift
//  Leader
//
//  Created by Taryn Neal on 7/24/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
//import FirebaseUI

class CurrentEventsVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
@IBOutlet var currentEventsTableView: UITableView!

var db: Firestore!
var DocRef : Query?
var dataCount : Int?
var userID : String?
var currentUser : Query?
var currentChapter : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        DocRef = db.collection("currentevents").whereField("chapter", isEqualTo: "Marysville Getchell ")
//        currentUser = db.collection("members").whereField("user UID", isEqualTo: userID)
//        userID = Auth.auth().currentUser?.uid
//        if userID == nil {
//            userID = ""
//        } else {
//            return
//        }
        //currentEventsTableView.separatorStyle = .none
     
        currentEventsTableView.reloadData()
    }


        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentEventsCell", for: indexPath as IndexPath) as! CurrentEventsCell

//            currentUser?.getDocuments(){ (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                    //Put more error handling here
//                } else {
//                    for document in querySnapshot!.documents {
//                        self.currentChapter = document.get("chapter") as? String
//                        self.DocRef = self.db.collection("currentevents").whereField("chapter", isEqualTo: self.currentChapter!)
//                        print("Got it!")
//                    }
//                }
//            }
            
            DocRef?.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    //Put more error handling here
                } else {
                    self.dataCount = querySnapshot?.count
                    //Here it's getting the data
                    print("\(self.dataCount)")
                   // print("\(querySnapshot?.count)")
                   // let snap = querySnapshot
                   // self.dataCount = snap?.count { get }
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        
                        cell.nameLabel.text = document.get("name") as? String
                        //While the strings work, the timestamp doesn't. Will need to look into more.
                    //    cell.dateLabel.text = "\(document.get("date") ?? "")"
                        cell.descriptionLabel.text = document.get("description") as? String
                        
                    }
                    
                }
            }
            
            return cell
            
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
            return dataCount ?? 1
            //Problem is getting data is so slow that it always just returns 1
        
        }

//    func setData() {
//        let data: [String: Any] = [:]
//        db.collection("chapter").document("new-chapter-id").setData(data)
////    }
    func addToFirestore() {
//        var ref: DocumentReference? = nil
//        ref = db.collection("users").addDocument(data: [
//            "first": "Ada",
//            "last": "Lovelace",
//            "born": 1815
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//            }
//        }

    }

}

class CurrentEventsCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}

