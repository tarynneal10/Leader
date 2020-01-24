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
import SDWebImage
import FirebaseUI

class ChapterVC : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet weak var chapterDescriptionLabel: UILabel!
    @IBOutlet weak var officerView: UICollectionView!
    @IBOutlet weak var view1: UIView!
    
    var db: Firestore!
    var storage : Storage!
    
    var DocRef : Query?
    var userRef : Query?
    var chapterRef : Query?
    var storageRef : StorageReference?
    
    var chapterName = ""
    var officerArray : [String] = []
    var urlArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        storage = Storage.storage()
        
        officerView.delegate = self
        officerView.dataSource = self
        
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
            self.populateOfficers()
        }
    }
    }
    
    //Gets officers
    func populateOfficers() {
        DocRef?.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                //Put more error handling here
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let position = document.get("position") as? String
                    let name = document.get("name") as? String
                    //let url = document.get("imageURL") as? String
                    
                    if position != "Member", position != "Advisor" {
                        self.officerArray.append("\(position!): \(name!)")
                        self.storageRef = self.storage.reference(forURL: "gs://leader-8bab1.appspot.com/untitled.png")
                    }
                    
                }
                self.officerView.reloadData()
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return officerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "officerCell", for: indexPath) as! OfficerCell
        //let placeholderImage = UIImage(named: "Anon")
        cell.image.image = UIImage(named: "Anon")
        cell.label.text = officerArray[indexPath.row]
        //cell.image.sd_setImage(with: storageRef!, placeholderImage: placeholderImage)
        
        return cell
    }
}
class OfficerCell : UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
}


