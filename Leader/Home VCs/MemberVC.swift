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
    
    
    var memberPosition : String?
     var chapterName = ""
     var paidStatus : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getUser()
    }
    override func viewDidDisappear(_ animated: Bool) {
        updateData()
    }
    //Updates data in cloud
    func updateData() {
        //Since I have to update every value in a loop, this can help limit the number of writes
        print(memberPosition)
        if memberPosition != nil, memberPosition != "Member" {
            for (index, value) in members.enumerated() {
                //paidStatus = value.paid
                let indexPath = IndexPath(row: index, section: 0)
                guard let cell = tableView.cellForRow(at: indexPath) as? MemberTableViewCell else { return }
                guard let paid = cell.paid else { return }
                //This is here also to prevent writes
                if paid != value.paid {
                    db.collection("members").document(value.docID).updateData([
                        "paid" : paid
                    ]) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!")
                                }
                    }
                }
            }
        }
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
                self.chapterName = (document.get("chapter") as? String)!
                self.memberPosition = document.get("position") as? String
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
                            let paid = document.get("paid") as? Bool
                            let doc = document.documentID
                            
                            self.members.append(Member(memberName: name ?? "name", memberPaid: paid ?? false, memberDoc: doc))
                            
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
        
            if memberPosition != nil, memberPosition == "Member" {
                cell.paidButton.isHidden = true
            }
        
             return cell
    }
    
    
}

//MARK: MemberTableViewCell Class

class MemberTableViewCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var paidButton: UIButton!
    
    var paid : Bool?
    
    override func awakeFromNib() {
          super.awakeFromNib()
        paid = false
      }

    func populate(member: Member) {
        nameLabel.text = member.name
        if member.paid == true {
            paidButton.setTitle("Paid", for: .normal)
            paid = true
        } else {
            paidButton.setTitle("Unpaid", for: .normal)
            paid = false
        }

    }
    
    @IBAction func paidPressed(_ sender: Any) {
        if paid == false {
            paidButton.setTitle("Paid", for: .normal)
            paid = true
        } else {
            paidButton.setTitle("Unpaid", for: .normal)
            paid = false
        }
    }
    
}
