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
//import Realm
//import RealmSwift

class CurrentEventsVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
@IBOutlet var currentEventsTableView: UITableView!

   var db: Firestore!
    var query : Query?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add a new document with a generated ID
        db = Firestore.firestore()
        query = db.collection("currentevents").whereField("chapter", isEqualTo: "Marysville Getchell")
        
        //currentEventsTableView.separatorStyle = .none
        //Could make values like the ones below and use later on for more automation
        //let chapterName = currentUser.chapter
        //let chapter = realm.objects(Chapter.self).filter("name like \(chapterName)"

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentEventsTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return currentEventsTitles.count
        //return currentEvents?.count ?? 1
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "currentEventsCell", for: indexPath as IndexPath) as! CurrentEventsCell
//        query?.getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    //                    if let event = document.data()[indexPath.row] {
//                    //                      //  cell.nameLabel?.text = document.data()
//                    //
//                    //                    }
//                    //                    else {
//                    //                        //            cell.nameLabel?.text = "No Items Added"
//                    //                        //            //Set up better GUI protocols here- maybe something like cell.imageView.hidden = true at first, then set to false here & tap into the .hidden of other objects and set to true.
//                    //                    }
//                    cell.nameLabel?.text = "\(document.data())"
//                    print("\(document.documentID) => \(document.data())")
//                }
              let docRef = db.collection("currentevents").document("4GB8y70hAf92oPIVFib3")
//                let currentEventDoc = db.collection("currentevents").whereField("chapter", isEqualTo: "Marysville Getchell")
//
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let property = document.get("title")
                        cell.nameLabel?.text = "\(String(describing: property))"
                       // print("\(property)")
                      //  print("Document data: \(document.data())")
                    } else {
                        print("Document does not exist")
                    }
        }
//        db.collection("currentevents").whereField("chapter", isEqualTo: "Marysville Getchell")
//        .getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
////                    if let event = document.data()[indexPath.row] {
////                      //  cell.nameLabel?.text = document.data()
////
////                    }
////                    else {
////                        //            cell.nameLabel?.text = "No Items Added"
////                        //            //Set up better GUI protocols here- maybe something like cell.imageView.hidden = true at first, then set to false here & tap into the .hidden of other objects and set to true.
////                    }
//
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
       // }
        
        
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

    func readFromFirestore() {
        db.collection("currentevents").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    func getCurrentEvents() {

    }
    
}
    

class CurrentEventsCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
}
