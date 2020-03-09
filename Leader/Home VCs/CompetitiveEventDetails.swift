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
import SafariServices

class CompetitiveEventDetailsVC : UIViewController, UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var db: Firestore!
    var DocRef : Query?
    var passedValue = ""
    var overview : String?
    var topic : String?
    var skills : String?
    var eventURL : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        db = Firestore.firestore()
        DocRef = db.collection("competitiveevents").whereField("name", isEqualTo: passedValue)
        loadDetails()
        
    }
//MARK: Retrieving from cloud
    func loadDetails() {
        DocRef?.getDocuments() { (QuerySnapshot, err) in
            if err != nil {
                print("Error getting documents: \(String(describing: err))");
            }
            else {
                for document in QuerySnapshot!.documents {
                    let name = document.get("name") as? String
                    let type = document.get("type") as? String
                    let category = document.get("category") as? String
                    
                    self.overview = document.get("overview") as? String
                    self.topic = document.get("topic") as? String
                    self.skills = document.get("skills") as? String
                    self.eventURL = document.get("url") as? String
                    
                    self.categoryLabel.text = "Category: \(category!)"
                    self.typeLabel.text = "Type: \(type!)"
                    self.nameLabel.text = name
                    
                    print(document.data())
                }
                self.tableView.reloadData()
            }
        }
    }
    //MARK: Table View Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath as IndexPath) as! DetailCell
        
        cell.label.text = "Overview"
        cell.details.text = overview
        cell.topic.text = topic
        cell.skills.text = skills

        return cell
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let eventToPass = nameLabel.text
        let viewController = segue.destination as? YourCompetitiveEventsVC
        viewController?.passedValue = eventToPass!
    }
    
    @IBAction func eventDetailsPressed(_ sender: Any) {
            let urlString = eventURL!
            guard let url = URL(string: urlString) else { return }
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
    }
}
//MARK: DetailCell Class

class DetailCell : UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var skills: UILabel!
}
