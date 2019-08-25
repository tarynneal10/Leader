//
//  CurrentEventsVC.swift
//  Leader
//
//  Created by Taryn Neal on 7/24/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
//import Realm
//import RealmSwift

class CurrentEventsVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
@IBOutlet var currentEventsTableView: UITableView!
//    let realm = try! Realm()
//    var currentEvents: List<CurrentEvent>?
//    var currentChapter : Results<Chapter>?
//
    override func viewDidLoad() {
        super.viewDidLoad()
        //currentEventsTableView.separatorStyle = .none
        //Code to add a current event to realm
//        let currentEvent = CurrentEvent()
//        currentEvent.eventTitle = "Best Day of the year"
//        currentEvent.eventDate = "10/10/19"
//        currentEvent.eventDescription = "Because it is. meet @ 7:35am"
//        try! realm.write  {
//            realm.add(currentEvent)
//           // currentChapter?.currentEvents.append(currentEvent)
//        }
        //Could make values like the ones below and use later on for more automation
        //let chapterName = currentUser.chapter
        //let chapter = realm.objects(Chapter.self).filter("name like \(chapterName)")
        
        loadCurrentEvents()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentEventsTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return currentEventsTitles.count
        //return currentEvents?.count ?? 1
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "currentEventsCell", for: indexPath as IndexPath) as! CurrentEventsCell
//
//        if let event = currentEvents?[indexPath.row] {
//
//            cell.nameLabel?.text = event.eventTitle
//            cell.dateLabel?.text = event.eventDate
//            cell.descriptionLabel?.text = event.eventDescription
//
//        }
//        else {
//            cell.nameLabel?.text = "No Items Added"
//            //Set up better GUI protocols here- maybe something like cell.imageView.hidden = true at first, then set to false here & tap into the .hidden of other objects and set to true.
//        }
       return cell
        
    }
    func loadCurrentEvents() {
      //  let predicate = NSPredicate(format: "name = %@", "Marysville Getchell")
        // let predicate = NSPredicate(format: "color = %@ AND name BEGINSWITH %@", "tan", "B")
//        currentChapter = realm.objects(Chapter.self).filter(predicate)
//        currentEvents = currentChapter?.first?.currentEvents

        currentEventsTableView.reloadData()
        
    }

}

class CurrentEventsCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
}
