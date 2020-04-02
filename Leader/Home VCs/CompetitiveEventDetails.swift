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
    var eventURL : String?
    
    var sectionTitles = [""]
    var sectionInfo = [[""]]
    
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
                self.sectionTitles.removeAll()
                self.sectionInfo.removeAll()
                for document in QuerySnapshot!.documents {
                    let name = document.get("name") as? String
                    let type = document.get("type") as? String
                    let category = document.get("category") as? String
                    let overview = document.get("overview") as? [String: String]
                    
                    self.eventURL = document.get("url") as? String
                    
                    for (key, value) in overview! {
                        self.sectionTitles.append(key)
                        self.sectionInfo.append([value])
                    }
                    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionInfo[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath as IndexPath) as! DetailCell
        
        cell.label.text = sectionInfo[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor(red: 21, green: 103, blue: 147)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(red: 255, green: 219, blue: 3)
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
//MARK: DetailCell Class & Color stuff

class DetailCell : UITableViewCell{
    @IBOutlet weak var label: UILabel!
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
