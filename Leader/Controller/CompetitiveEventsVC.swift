//
//  CompetitiveEventsVC.swift
//  Leader
//
//  Created by Taryn Neal on 7/24/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class CompetitiveEventsVC : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var competitiveEventsTableView: UITableView!
    let realm = try! Realm()
    var competitiveEvents : Results<CompetitiveEvents>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Code to add a competitive event to realm- could make array when finially want to add all of them for prod- for now just add a few to test
//                let newEvent = CompetitiveEvents()
//                newEvent.name = "Mobile App"
//                newEvent.category = "Demonstration"
//                newEvent.type = "Individual or Team"
//                try! realm.write  {
//                    realm.add(newEvent)
//                }
        loadCompetitiveEvents()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitiveEvents?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "competitiveEventsCell", for: indexPath as IndexPath) as! CompetitiveEventsCell
        
        if let event = competitiveEvents?[indexPath.row] {
            
            cell.eventName?.text = event.name
            cell.eventCategory?.text = event.category
            cell.eventType?.text = event.type
            
        }
        else {
            cell.eventName?.text = "No Items Added"
            cell.eventCategory?.isHidden = true
            cell.eventType?.isHidden = true
            //Set up better GUI protocols here- maybe something like cell.imageView.isHidden = true at first, then set to false here & tap into the .isHidden of other objects and set to true.
        }
        return cell
    }
    func loadCompetitiveEvents() {
        competitiveEvents = realm.objects(CompetitiveEvents.self)
        competitiveEventsTableView.reloadData()
    }
}
//Code example for search bar methods
//extension CompetitiveEventsVC: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        competitiveEvents = competitiveEvents?.filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "name", ascending: true)
//
//        competitiveEventsTableView.reloadData()
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadCompetitiveEvents()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//
//        }
//    }
//
//}
class CompetitiveEventsCell : UITableViewCell{
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventCategory: UILabel!
    @IBOutlet weak var eventType: UILabel!
}
