//
//  ArchiveDetailsVC.swift
//  Leader
//
//  Created by Taryn Neal on 3/8/20.
//  Copyright © 2020 Taryn Neal. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import SVProgressHUD

class ArchiveDetailsVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var db: Firestore!
    
    var sectionTitles = ["Attendees", "Minutes"]
    var sectionInfo : [[String]] = [[""],[""]]
    var passedDate = ""
    var passedSubject = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        SVProgressHUD.show()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 30.0
        tableView.rowHeight = UITableView.automaticDimension
        
        getMeeting()
    }
    
    func getMeeting() {
        let docRef = db.collection("minutes").whereField("date", isEqualTo: self.passedDate).whereField("subject", isEqualTo: self.passedSubject)
        docRef.getDocuments() { (QuerySnapshot, err) in
            if err != nil {
                print("Error getting documents: \(String(describing: err))");
                SVProgressHUD.dismiss()
            }
            else {
                if let snapshot = QuerySnapshot {
                    for document in snapshot.documents {
                        print("\(document.documentID) => \(document.data())")
                        
                        let minutes = document.get("minutes") as? [String:String?]
                        let attendees = document.get("attendees") as? [String]
                        
                        var array = [String]()
                        for (key, value) in minutes! {
                            array.append("\(key): \(value!)")
                        }
                        array = array.sorted(by: { $0 < $1})
                        //If possible, change sorting parameters to more exact values
                        self.sectionInfo = [attendees!, array]
                    }
                    SVProgressHUD.dismiss()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionInfo[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "archiveDetailsCell", for: indexPath as IndexPath) as! ArchiveDetailsCell
        
        cell.label.text = sectionInfo[indexPath.section][indexPath.row]
        
        return cell
    }
}

class ArchiveDetailsCell : UITableViewCell {
    @IBOutlet weak var label: UILabel!
}
