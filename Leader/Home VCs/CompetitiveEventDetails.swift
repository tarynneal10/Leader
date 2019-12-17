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

class CompetitiveEventDetailsVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var db: Firestore!
    var DocRef : Query?
    var passedValue = ""
    var sectionTitles = ["Overview", "Guidelines", "Preparation", "Alignment"]
    var sectionInfo : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
       // loadCompetitiveEvents()
        db = Firestore.firestore()
        DocRef = db.collection("competitiveevents").whereField("name", isEqualTo: passedValue)
       // nameLabel.text = passedValue
        loadDetails()
        //print("\(String(describing: passedValue))")
        setTextValues()
        
    }
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
                    
//                    self.categoryLabel.text = "Category: \(category!)"
//                    self.typeLabel.text = "Type: \(type!)"
//                    self.nameLabel.text = name
                    self.sectionInfo = [overview!]
                    print(document.data())
                }
                
            }
            
        }

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionTitles.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath as IndexPath) as! DetailCell
        cell.label.text = sectionTitles[indexPath.row]
        
//        let listPath = events[indexPath.row]
//        cell.populate(competitiveEvent: listPath)
//
        return cell
    }
    
//    func selectedEvent() {
//        competitiveEvents = realm.objects(CompetitiveEvents.self).filter("")
//    }
    func findEventDetails() {
        
    }
    func setTextValues() {
//        typeLabel.text = competitiveEventsDetails?.first?.type
//        categoryLabel.text = competitiveEventsDetails?.first?.category
//        nameLabel.text = competitiveEventsDetails?.first?.name
////Should probs set up a parameter or two for when there's no value
    }
//
}

class DetailCell : UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
}
class TitleCell : UITableViewCell {
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var name: UILabel!
}
