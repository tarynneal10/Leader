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
import SVProgressHUD
import SafariServices

class CompetitiveEventsVC : UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    @IBOutlet var competitiveEventsTableView: UITableView!
    
    var db: Firestore!
    var DocRef : Query?
    var events: [CompetitiveEvent] = []
    var valueToPass = ""
    var viewController : CompetitiveEventDetailsVC?
    var eventName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        db = Firestore.firestore()
        DocRef = db.collection("competitiveevents")
        SVProgressHUD.show()
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
                    SVProgressHUD.dismiss()
                    //Put like an error pop up or something
                }
                else
                {
                    self.events.removeAll()
                    for document in QuerySnapshot!.documents {
                        
                        let name = document.get("name") as? String
                        let category = document.get("category") as? String
                        let type = document.get("type") as? String
                        
                        self.eventName = name
                        self.events.append(CompetitiveEvent(eventName: name!, eventCategory: category!, eventType: type!))
                        print(document.data())
                    }
                    SVProgressHUD.dismiss()
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
//    // This function is called before the segue
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // get a reference to the second view controller
//        viewController = segue.destination as? CompetitiveEventDetailsVC
//        // set a variable in the second view controller with the String to pass
//        
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        var urlString = "https://www.fbla-pbl.org/competitive-event/\(eventName)-fbla/"
        guard let url = URL(string: urlString) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
//        // Get Cell Label
//        let indexPath = tableView.indexPathForSelectedRow
//        let currentCell = tableView.cellForRow(at: indexPath!) as! CompetitiveEventsCell
//        tableView.deselectRow(at: indexPath!, animated: true)
//        valueToPass = currentCell.eventName!.text!
//        viewController?.passedValue = valueToPass
//        print(valueToPass)
//        
    }
    



    

}
////Search Bar Code
//extension CompetitiveEventsVC: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        DocRef = db.collection("competitiveevents").whereField("name", isEqualTo: searchBar.text!)
//        events = createArray()
//        //Problem- only returns values if typed in exactly right and only for name field
//        competitiveEventsTableView.reloadData()
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            DocRef = db.collection("competitiveevents")
//            events = createArray()
//            competitiveEventsTableView.reloadData()
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
    func populate(competitiveEvent: CompetitiveEvent) {
        eventName.text = competitiveEvent.name
        eventCategory.text = competitiveEvent.category
        eventType.text = competitiveEvent.type
    }
}
