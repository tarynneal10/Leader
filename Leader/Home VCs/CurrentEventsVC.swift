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
import SVProgressHUD
//import FirebaseUI

class CurrentEventsVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
@IBOutlet var currentEventsTableView: UITableView!

var db: Firestore!
var DocRef : Query?
var userRef : Query?
var list: [CurrentEvent] = []
var chapterName = ""
var receivedString = ""
let formatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        navigationItem.title = receivedString
        SVProgressHUD.show()
        
     //   self.currentEventsTableView.reloadData()
    //currentEventsTableView.separatorStyle = .none
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUser()
        currentEventsTableView.reloadData()
    }
    @IBAction func unwindToCurrentEvents(segue: UIStoryboardSegue) {
        //nothing goes here
    }
    func createArray() -> [CurrentEvent]
    {
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
                        let date = document.get("date") as? Timestamp
                        let description = document.get("description") as? String
                        //Maybe could put if statement for date here
//                        let date1 = date
//                        let date2 = Date()
//                        if date1 > date2 {
//
//                        }
                        self.list.append(CurrentEvent(eventName: name!, eventDate: date!, eventDescription: description!))
                        print(document.data())
                    }
                    SVProgressHUD.dismiss()
                    self.currentEventsTableView.reloadData()
                }
  
        }

        return list
    }
    func getUser() {
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
                    self.chapterName = chapter!
                    self.DocRef = self.db.collection("currentevents").whereField("chapter", isEqualTo: self.chapterName)
                    
                }
                self.list = self.createArray()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       return list.count
        
    }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentEventsCell", for: indexPath as IndexPath) as! CurrentEventsCell
            let listPath = list[indexPath.row]
            cell.populate(currentEvent: listPath)
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }

}

class CurrentEventsCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    func populate(currentEvent: CurrentEvent) {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM/dd/yyyy"  formatter.string(from: currentEvent.date)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let date = currentEvent.date.dateValue()
    
        nameLabel.text = currentEvent.name
        dateLabel.text = formatter.string(from: date)

        descriptionLabel.text = currentEvent.description
    }
}

