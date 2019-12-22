//
//  CompetitiveEventDetails.swift
//  Leader
//
//  Created by Taryn Neal on 8/23/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SVProgressHUD

class CompetitiveEventDetailsVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var db: Firestore!
    var DocRef : Query?
    var passedValue = ""
    var sectionTitles : [String] = []
    var sectionInfo : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionTitles = ["Overview", "Guidelines", "Preparation", "Alignment"]

        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 34.0
        tableView.rowHeight = UITableView.automaticDimension
        
        db = Firestore.firestore()
        DocRef = db.collection("competitiveevents").whereField("name", isEqualTo: passedValue)
        loadDetails()
        
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    func loadDetails() {
        DocRef?.getDocuments() { (QuerySnapshot, err) in
            if err != nil
            {
                print("Error getting documents: \(String(describing: err))");
            }
            else
            {
                
                for document in QuerySnapshot!.documents {
                    
                    let name = document.get("name") as? String
                    let type = document.get("type") as? String
                    let category = document.get("category") as? String
                    
                    let overview = document.get("overview") as? String
                    let guidelines = document.get("guidelines") as? String
                    let preparation = document.get("preparation") as? String
                    let alignment = document.get("alignment") as? String
                    
                    self.categoryLabel.text = "Category: \(category!)"
                    self.typeLabel.text = "Type: \(type!)"
                    self.nameLabel.text = name
                    
                    self.sectionInfo = [overview!, guidelines!, preparation!,  alignment!]
                    
                    print(document.data())
                }
                self.tableView.reloadData()
            }
            
        }

        
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        return sectionTitles[section]
//
//    }
//
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//
//    return sectionTitles.count
//
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath as IndexPath) as! DetailCell
        
        cell.label.text = sectionTitles[indexPath.row]
        cell.textView.text = sectionInfo[indexPath.row]

        return cell
    }

}

class DetailCell : UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!

}
