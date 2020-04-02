//
//  MemberVC.swift
//  Leader
//
//  Created by Taryn Neal on 12/28/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SVProgressHUD

class MemberViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
     var db: Firestore!
     var DocRef : Query?
     var userRef : Query?
     var members : [Member] = []
     var chapterName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
            }
            self.getMembers()
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
                        
                        self.members = self.members.sorted(by: {$0.name < $1.name})
                        self.tableView.reloadData()
                    
                    }
                }
                
            }

    }
    
//MARK: Table View Functions
    
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

//MARK: MemberTableViewCell Class

class MemberTableViewCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    func populate(member: Member) {
        nameLabel.text = member.name
    }
    
}
