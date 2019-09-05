//
//  CompetitiveEventsVC.swift
//  Leader
//
//  Created by Taryn Neal on 7/24/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit

class CompetitiveEventsVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var competitiveEventsTableView: UITableView!
//    let realm = try! Realm()
//    var competitiveEvents : Results<CompetitiveEvents>?
//    var selectedEvent : CompetitiveEvents?
//    var selectedRow : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Code to add a competitive event to realm- could make array when finially want to add all of them for prod- for now just add a few to test
//                let newEvent = CompetitiveEvents()
//                newEvent.name = "3-D Animation"
//        newEvent.category = "Prejuged Project"
//                newEvent.type = "Why"
//                try! realm.write  {
//                    realm.add(newEvent)
//                }
       
        
     //   loadCompetitiveEvents()
        
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "competitiveEventsCell", for: indexPath as IndexPath) as! CompetitiveEventsCell
//        if let event = competitiveEvents?[indexPath.row] {
//            
//            cell.eventName?.text = event.name
//            cell.eventCategory?.text = event.category
//            cell.eventType?.text = event.type
//            
//        }
//        else {
//            cell.eventName?.text = "No Items Added"
//            cell.eventCategory?.isHidden = true
//            cell.eventType?.isHidden = true
//            //Set up better GUI protocols here- maybe something like cell.imageView.isHidden = true at first, then set to false here & tap into the .isHidden of other objects and set to true.
//        }
        return cell
    }
//    func loadCompetitiveEvents() {
//        competitiveEvents = realm.objects(CompetitiveEvents.self)
//        competitiveEventsTableView.reloadData()
//    }
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
    
//* Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'unable to dequeue a cell with identifier competitiveEventsCell - must register a nib or a class for the identifier or connect a prototype cell in a storyboard'- This is the error from when I try and run the app
}
class CompetitiveEventsCell : UITableViewCell{
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventCategory: UILabel!
    @IBOutlet weak var eventType: UILabel!
}
