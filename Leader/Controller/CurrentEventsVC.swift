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
    var dataCount : QuerySnapshot?
var userID : String?
var currentUser : Query?
var currentChapter : String?
var list: [CurrentEvent] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        DocRef = db.collection("currentevents").whereField("chapter", isEqualTo: "Marysville Getchell")
        getCount()
        list = createArray()
     //   self.currentEventsTableView.reloadData()
//        currentUser = db.collection("members").whereField("user UID", isEqualTo: userID)
//        userID = Auth.auth().currentUser?.uid
//        if userID == nil {
//            userID = ""
//        } else {
//            return
//        }
        //currentEventsTableView.separatorStyle = .none
    }



    func getCount() {
        DocRef?.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            self.dataCount = querySnapshot
            self.currentEventsTableView.reloadData() // if it's a background thread embed code in DispatchQueue.main.async {---}
        }
    }
    func createArray() -> [CurrentEvent]
    {
      //  let tempTxt: [CurrentEvent] = []
        
        //Authentication
      //  let authentication = Auth.auth().currentUser?.uid
        
        //Choosing collection
        DocRef?.getDocuments()
            { (QuerySnapshot, err) in
                if err != nil
                {
                    print("Error getting documents: \(String(describing: err))");
                }
                else
                {
                    self.list.removeAll()
                    for document in QuerySnapshot!.documents {

                        let name = document.get("name") as? String
                        let date = document.get("date") as? Date
                        let description = document.get("description") as? String
                        self.list.append(CurrentEvent(eventName: name ?? "name", eventDate: date ?? Date(), eventDescription: description ?? "decription"))
                    }
                    
                    self.currentEventsTableView.reloadData()
                }
  
        }

        return list
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       return list.count
        
    }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentEventsCell", for: indexPath as IndexPath) as! CurrentEventsCell
            let listPath = list[indexPath.row]
            cell.populate(currentEvent: listPath)

            
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
//            DocRef?.getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                    //Put more error handling here
//                } else {
//                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
//
//                        cell.nameLabel.text = document.get("name") as? String
//                        cell.dateLabel.text = "01/01/2020"
//                        cell.descriptionLabel.text = document.get("description") as? String
//                        //I can get the datacount accurately, but can't set the fields quite right
//
//                    }
//
//                }
//            }
        
            return cell


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
    func populate(currentEvent: CurrentEvent) {
        nameLabel.text = currentEvent.name
      //  dateLabel.text = currentEvent.date
        descriptionLabel.text = currentEvent.description
    }
}

