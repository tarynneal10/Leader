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

class ChapterVC : UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var officerCollectionView: UICollectionView!
    
    @IBOutlet weak var memberTableView: UITableView!
    @IBOutlet weak var chapterDescriptionLabel: UILabel!
    
    var db: Firestore!
    var DocRef : Query?
    var dataCount : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        DocRef = db.collection("members").whereField("chapter", isEqualTo: "Marysville Getchell")
        memberTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCount ?? 2
        //Not currently accurately returning data count- will fix later
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath as IndexPath) as! MemberTableViewCell
//        DocRef?.getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//                //Put more error handling here
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                    //self.dataCount = document.data().count
//                   cell.nameLabel.text = document.get("name") as? String
//
//                }
//            }
//        }
        return cell
    }
}

class MemberTableViewCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
}
