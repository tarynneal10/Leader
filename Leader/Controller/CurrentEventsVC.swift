//
//  CurrentEventsVC.swift
//  Leader
//
//  Created by Taryn Neal on 7/24/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit

class CurrentEventsVC : UITableViewController {
//    let devCourses = [("Logo2"),("HomeIcon"),("CalendarIcon"),("SettingsTabBarItem"),("SettingsIcon")]
//
//    let devCousesImages = [UIImage(named: "Logo2"), UIImage(named: "HomeIcon"), UIImage(named: "Logo2"), UIImage(named: "CalendarIcon"), UIImage(named: "HomeIcon")]
    override func viewDidLoad() {

        super.viewDidLoad()

    }

//
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return devCourses.count
//
//    }
//
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "currentEventsCell", for: indexPath as IndexPath) as! CurrentEventsCell
//
//        cell.photoImageView.image = self.devCousesImages[indexPath.row]
//
//        cell.nameLabel.text = self.devCourses[indexPath.row]
//
//        return cell
//    }
//    @IBOutlet var currentEventsTableView: UITableView!
//
//    let myarray = ["item1", "item2", "item3"]
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        currentEventsTableView.reloadData()
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myarray.count
//    }
//
//
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "currentEventsCell", for: indexPath as IndexPath)
//        cell.textLabel?.text = myarray[indexPath.item]
//        return cell
//    }
    
}

class CurrentEventsCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
}

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "currentEventsCell", for: indexPath)
//            as! CurrentEventsCell
//
//        cell.nameLabel?.text = "titles"
//        cell.dateLabel?.text = "yikes"
//        cell.photoImageView?.image = UIImage(named: "Logo2")
//
//        return cell
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//
//
//    let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
//
//    print("\(#function) --- section = \(indexPath.section), row = \(indexPath.row)")
//
//    cell.textLabel?.text = contacts[indexPath.row][0]
//
//    return cell


