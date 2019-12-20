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

    @IBOutlet weak var collectionTableView: UITableView!
    @IBOutlet weak var chapterDescriptionLabel: UILabel!
    var storedOffsets = [Int: CGFloat]()
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
        print(chapterName)
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
        }
    }
    }
    func getMembers() {
        if chapterName != "" {
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
        else {
            print("Error, chapterName is empty")
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1 + members.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customIndexPath = NSIndexPath(index: indexPath.row - 2)
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath as IndexPath) as! CollectionCell
             cell.image1.image = UIImage(named: "Anon")
             cell.label1.text = "President"
            return cell
            
        } else {
            // let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath as IndexPath) as! MemberTableViewCell
             let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath as IndexPath)as! MemberTableViewCell
                   //Problem is that this code put the indexpath.row out of range for this
             let path = members[customIndexPath.row]
             //cell.populate(member: path)

             return cell

        }
    }


}

//extension ChapterVC : UICollectionViewDataSource, UICollectionViewDelegate {
//
//    //Collection view functions
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "officerCell", for: indexPath as IndexPath) as! OfficerCell
//        cell.officerPosition.text = "President"
//        cell.officerImage.image = UIImage(named: "Anon")
//        return cell
//    }
//}
class MemberTableViewCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    func populate(member: Member) {
        nameLabel.text = member.name
    }
    
}
class CollectionCell : UITableViewCell {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
}
//extension CollectionCell {
//    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
//        officerCollectionView.delegate = dataSourceDelegate
//        officerCollectionView.dataSource = dataSourceDelegate
//        officerCollectionView.reloadData()
//    }
//}
//class OfficerCell : UICollectionViewCell {
//    @IBOutlet weak var officerImage: UIImageView!
//    @IBOutlet weak var officerPosition: UILabel!
//
//}
