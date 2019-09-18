//
//  CompetitiveEventsVC.swift
//  Leader
//
//  Created by Taryn Neal on 7/24/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class CompetitiveEventsVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var competitiveEventsTableView: UITableView!
    var db: Firestore!
    var DocRef : Query?
    var dataCount : Int?
    var events: [CompetitiveEvent] = []
//    var selectedEvent : CompetitiveEvents?
//    var selectedRow : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        db = Firestore.firestore()
        DocRef = db.collection("competitiveevents")
        events = createArray()
        competitiveEventsTableView.reloadData()
    }
    func createArray() -> [CompetitiveEvent]
    {
        DocRef?.getDocuments()
            { (QuerySnapshot, err) in
                if err != nil
                {
                    print("Error getting documents: \(String(describing: err))");
                }
                else
                {
                    self.events.removeAll()
                    for document in QuerySnapshot!.documents {
                        
                        let name = document.get("name") as? String
                        let category = document.get("category") as? String
                        let type = document.get("type") as? String
                        self.events.append(CompetitiveEvent(eventName: name!, eventCategory: category!, eventType: type!))
                        print(document.data())
                    }
                    
                    self.competitiveEventsTableView.reloadData()
                }
                
        }
        
        return events
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "competitiveEventsCell", for: indexPath as IndexPath) as! CompetitiveEventsCell
        let listPath = events[indexPath.row]
        cell.populate(competitiveEvent: listPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row >= 0 {
//        }
       // selectedRow = indexPath.row
       //var amountOfEvents = competitiveEvents?.count
       
        
        
        //Now I have it's number
       // var selectedItem = indexPath.item
        //So from the copetitive events results that I'm currently sorting through I can get the values of what is first and what is last. From the indexpath.row/.item I can get the integer number of the row that I clicked on. I am sorting the results by when they were added (Need to change that soon) and I need a way to sort through them and say I want result number two because I clicked indexPath.row number two. I can also get the total number of competitiveEvents
      //  selectedEvent?.name = indexPath.row
        
       // indexPath.row.eventName
        //competitiveEvents?.first?. =
        //selectedEvent = competitiveEvents.
        
    //Might be able to do it by setting up an integer value for each of the events ... I'm sorting by name right now. Going to try todoey's version rn but ultimately will probs end up attributing to some value when loaded here then cqallling this class and tapping into that value. Could also reference center card's code.
    }
}
//Code example for search bar methods- note that it crashes every time I click search
extension CompetitiveEventsVC: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
     //   competitiveEvents = competitiveEvents?.filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "name", ascending: true)
        //let SearchQuery = db.collection("competitiveevents")
//Still need to get it to accept search filters for category and type
        
        competitiveEventsTableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
           // loadCompetitiveEvents()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
    
}
class CompetitiveEventsCell : UITableViewCell{
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventCategory: UILabel!
    @IBOutlet weak var eventType: UILabel!
    func populate(competitiveEvent: CompetitiveEvent) {
        eventName.text = competitiveEvent.name
        eventCategory.text = competitiveEvent.category
        eventType.text = competitiveEvent.type
    }
}
