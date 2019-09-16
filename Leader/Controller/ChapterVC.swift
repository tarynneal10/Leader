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

class ChapterVC : UIViewController{

    @IBOutlet weak var officerCollectionView: UICollectionView!
    @IBOutlet weak var memberTableView: UITableView!
    @IBOutlet weak var chapterDescriptionLabel: UILabel!
    
    var db: Firestore!
   // var storage : Storage!
    var DocRef : Query?
    var chapterRef : Query?
    var members : [Member] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()
       // storage = Storage.storage()
        DocRef = db.collection("members").whereField("chapter", isEqualTo: "Marysville Getchell")
        chapterRef = db.collection("chapter").whereField("name", isEqualTo: "Marysville Getchell")
        setDescription()
        //gets members for table view - here bc wouldn't work work anywhere else
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
                                    self.memberTableView.reloadData()
                                }
                            }
                        }
        
                    }
        //Done getting members
        
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
  

}
extension ChapterVC : UICollectionViewDataSource, UICollectionViewDelegate {
    //Collection view functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "officerCell", for: indexPath as IndexPath) as! OfficerCell
        return cell
    }
    
}
extension ChapterVC : UITableViewDelegate, UITableViewDataSource {
    //Tableview functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath as IndexPath) as! MemberTableViewCell
        
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
class OfficerCell : UICollectionViewCell {
    @IBOutlet weak var officerImage: UIImageView!
    @IBOutlet weak var officerPosition: UILabel!
    
}
