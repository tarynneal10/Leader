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
//    var currentChapter : Chapter? {
//        didSet{
//            loadItems()
//        }
//    }
  //  var currentChapter : Chapter?
   // let chapter = Chapter()

 //   let currentEventsDates = [("9/6/19"),("8/4/19"),("1/2/20"),("4/3/5"),("3/5/6")]
  //  let currentEventsImages = [UIImage(named: "Logo2"), UIImage(named: "HomeIcon"), UIImage(named: "Logo2"), UIImage(named: "CalendarIcon"), UIImage(named: "HomeIcon")]
  //  let currentEvent = CurrentEvent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //currentEventsTableView.separatorStyle = .none
        //Code to add a current event to realm
//        let currentEvent = CurrentEvent()
//        currentEvent.eventTitle = "Best Day of the year"
//        currentEvent.eventDate = "10/10/19"
//        currentEvent.eventDescription = "Because it is. meet @ 7:35am"
////        currentEvent.eventImage = UIImage(named: "CurrentEventImageTest")
//        try! realm.write  {
//            realm.add(currentEvent)
//           // currentChapter?.currentEvents.append(currentEvent)
//        }
        //Code to filter through object values
    //let currentEvents = realm.objects(CurrentEvent.self).filter("parentChapter like 'Marysville Getchell'")
        //Could make values like the ones below and use later on for more automation
        //let chapterName = currentUser.chapter
        //let chapter = realm.objects(Chapter.self).filter("name like \(chapterName)")
        
        currentEventsTableView.reloadData()

       loadItems()
        print(currentEvents?.first as Any)
//         let currentChapter = realm.objects(Chapter.self).filter("name like 'Marysville Getchell'")
//        print(currentChapter)
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
           //let why = currentEvents?.filter("eventTitle like 'First Meeting of The Year'")
        //todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
//        let currentEventsTitles = currentEvents.eventTitle
//        let currentEventsDates = currentEvents.eventDate
//        let currentEventsDescriptions = currentEvents.eventDescription
//      //  cell.photoImageView?.image = currentEventsImages[indexPath.item]
//        cell.nameLabel?.text = currentEventsTitles[indexPath.item]
//        cell.dateLabel?.text = currentEventsDates[indexPath.item]
        //let cell = super.tableView(tableView, cellForRowAt: indexPath)

        if let event = currentEvents?[indexPath.row] {
            //current problem if something along the lines of the current event isn't actually associated with the chapter, but it is there- need to figure out to generate current event specifically for chapter- need to figure out how to programativally add new object to array- can also generate object then do manually?
            //problem is now that I can load up all the current events but I can't sort them by their parent category
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
            //Set up better GUI protocols here- maybe something like cell.imageView.hidden = true at first, then set to false here & tap into the .hidden of other objects and set to true.
        }
        return cell
       
    }
    func loadItems() {
        //currentEvents = currentChapter?.currentEvents.sorted(byKeyPath: "eventTitle", ascending: true)
        currentEvents = realm.objects(CurrentEvent.self)
//        let currentChapter = realm.objects(Chapter.self).filter("name like 'Marysville Getchell'")
//        currentEvents = currentChapter
        currentEventsTableView.reloadData()
        
    }

}

class CurrentEventsCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
}
