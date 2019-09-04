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

    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        DocRef = db.collection("currentevents").whereField("chapter", isEqualTo: "Marysville Getchell")

        //currentEventsTableView.separatorStyle = .none
        //Could make values like the ones below and use later on for more automation
        //let chapterName = currentUser.chapter
        //let chapter = realm.objects(Chapter.self).filter("name like \(chapterName)"
     //

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        currentEventsTableView.reloadData()
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
            return dataCount ?? 1
  
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentEventsCell", for: indexPath as IndexPath) as! CurrentEventsCell
            DocRef?.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    //Put more error handling here
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        self.dataCount = document.data().count
                        cell.nameLabel.text = document.get("name") as? String
                    }
                }
            }
            return cell
            
        }

    
    func loadCurrentEvents() {

        currentEventsTableView.reloadData()
        
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

    func getCurrentEvents() {

    }
    
}

class CurrentEventsCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}

