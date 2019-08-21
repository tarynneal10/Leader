//
//  CurrentEventsVC.swift
//  Leader
//
//  Created by Taryn Neal on 7/24/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class CurrentEventsVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
@IBOutlet var currentEventsTableView: UITableView!
    let realm = try! Realm()
    var currentEvents: Results<CurrentEvent>?
 //   let currentEventsDates = [("9/6/19"),("8/4/19"),("1/2/20"),("4/3/5"),("3/5/6")]
  //  let currentEventsImages = [UIImage(named: "Logo2"), UIImage(named: "HomeIcon"), UIImage(named: "Logo2"), UIImage(named: "CalendarIcon"), UIImage(named: "HomeIcon")]
  //  let currentEvent = CurrentEvent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentEventsTableView.separatorStyle = .none
//        currentEvent.eventTitle = "First Meeting of The Year"
//        currentEvent.eventDate = "9/12/2019"
//        currentEvent.eventDescription = "This is the first meetings of the 2019-2020 school year. It will be at 2:30pm in rm 202 ISC"
////        currentEvent.eventImage = UIImage(named: "CurrentEventImageTest")
//        try! realm.write  {
//            realm.add(currentEvent)
//        }
    //let currentEvents = realm.objects(CurrentEvent.self).filter("parentChapter like 'Marysville Getchell'")
//print(currentEvents.first as Any)
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentEventsTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return currentEventsTitles.count
        return currentEvents?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currentEventsCell", for: indexPath as IndexPath) as! CurrentEventsCell
//        let currentEventsTitles = currentEvents.eventTitle
//        let currentEventsDates = currentEvents.eventDate
//        let currentEventsDescriptions = currentEvents.eventDescription
//      //  cell.photoImageView?.image = currentEventsImages[indexPath.item]
//        cell.nameLabel?.text = currentEventsTitles[indexPath.item]
//        cell.dateLabel?.text = currentEventsDates[indexPath.item]
        //let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let event = currentEvents?[indexPath.row] {
            
            cell.nameLabel?.text = event.eventTitle
            cell.dateLabel?.text = event.eventDate
            cell.descriptionLabel?.text = event.eventDescription
            
            //cell.accessoryType = item.done ? .checkmark : .none
            
//            if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {
//
//                cell.backgroundColor = color
//                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
//
//            }
        }
        else {
            cell.nameLabel?.text = "No Items Added"
        }
        return cell
    }
    
}

class CurrentEventsCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
}
