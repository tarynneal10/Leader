//
//  ChapterVC.swift
//  Leader
//
//  Created by Taryn Neal on 9/6/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
//import FirebaseStorage

class ChapterVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
//I know theres probs a better way to do this but I haven't found it yet
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    
    @IBOutlet weak var collectionTableView: UITableView!
    @IBOutlet weak var chapterDescriptionLabel: UILabel!
    
    var db: Firestore!
   // var storage : Storage!
    var DocRef : Query?
    var userRef : Query?
    var chapterRef : Query?
    var members : [Member] = []
    var chapterName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
       // storage = Storage.storage()
        
        collectionTableView.delegate = self
        collectionTableView.dataSource = self

        getUser()
    }

    //Gets user for other queries
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
                self.navigationItem.title = self.chapterName
                self.DocRef = self.db.collection("members").whereField("chapter", isEqualTo: self.chapterName)
                self.chapterRef = self.db.collection("chapter").whereField("name", isEqualTo: self.chapterName)
            }
            self.setDescription()
            self.getMembers()
            self.populateOfficers()
        }
    }
    }
    
    //Gets officers for that mess
    func populateOfficers() {
        
        DocRef?.whereField("position", isEqualTo: "President").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                //Put more error handling here
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let name = document.get("name") as? String
                    self.label1.text = "President \(name!)"
                }
            }
        }
    }
    
    //Gets members for tableView
    func getMembers() {
            DocRef?.getDocuments() { (QuerySnapshot, err) in
                if err != nil
                {
                    print("Error getting documents: \(String(describing: err))");
                }
                else
                {
                    if let snapshot = QuerySnapshot {
                        self.members.removeAll()
                        for document in snapshot.documents {
                            let name = document.get("name") as? String
                            self.members.append(Member(memberName: name ?? "name"))
                            
                            print(document.data())
                        }
                        DispatchQueue.main.async {
                            self.collectionTableView.reloadData()
                        }
                    }
                }
                
            }

    }
    
    //Sets description for chapter text box
    func setDescription() {
        chapterRef?.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                //Put more error handling here
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.chapterDescriptionLabel.text = document.get("description") as? String
                }
            }
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath as IndexPath)as! MemberTableViewCell
    
             let path = members[indexPath.row]
             cell.populate(member: path)

             return cell
    }

}

class MemberTableViewCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    func populate(member: Member) {
        nameLabel.text = member.name
    }
    
}

