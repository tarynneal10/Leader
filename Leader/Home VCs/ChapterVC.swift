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
import SVProgressHUD

class ChapterVC : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var chapterDescriptionLabel: UILabel!
    @IBOutlet weak var officerView: UICollectionView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var officerViewHeight: NSLayoutConstraint!
    
    var db: Firestore!
    var storage : Storage!
    
    var DocRef : Query?
    var userRef : Query?
    var chapterRef : Query?
    
    var storageRef : [StorageReference] = []
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
        SVProgressHUD.show()
    }

//MARK: Retrieving from cloud
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
                //print("\(document.documentID) => \(document.data())")
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
                    //print("\(document.documentID) => \(document.data())")
                    
                    let position = document.get("position") as? String
                    let name = document.get("name") as? String
                    let url = document.get("imageURL") as? String
                    
                    if position != "Member", position != "Advisor" {
                        self.officerArray.append("\(position!): \(name!)")
                        self.storageRef.append(self.storage.reference(forURL: url!))
                    }
                    
                }
                SVProgressHUD.dismiss()
                
                self.officerView.reloadData()
                let viewHeight = self.officerView.collectionViewLayout.collectionViewContentSize.height
                self.officerViewHeight.constant = viewHeight
                self.view.setNeedsLayout()
                //self.view.layoutIfNeeded()
                //self.view.layoutSubviews()
                
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

//MARK: Collection View Functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return officerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "officerCell", for: indexPath) as! OfficerCell
        let placeholderImage = UIImage(named: "Anon")
        let photoUrl = storageRef[indexPath.row]
        
        cell.label.text = officerArray[indexPath.row]
        cell.image.sd_setImage(with: photoUrl, placeholderImage: placeholderImage)
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //let height = view.frame.size.height
        let width = view.frame.size.width
        
        // in case you you want the cell to be 40% of your controllers view
        return CGSize(width: width * 0.3, height: 155)
    }
    
    @IBAction func unwindToChapterVC(segue: UIStoryboardSegue) {
        print("Unwind to ChapterVC")
    }

}

//MARK: OfficerCell Class

class OfficerCell : UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //image.image = UIImage(named: "Anon")
    }
}


