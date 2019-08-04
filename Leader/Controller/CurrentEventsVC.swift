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
@IBOutlet var currentEventsTableView: UITableView!
    let currentEventsTitles = [("Logo2"),("HomeIcon"),("CalendarIcon"),("SettingsTabBarItem"),("SettingsIcon")]
    let currentEventsDates = [("9/6/19"),("8/4/19"),("1/2/20"),("4/3/5"),("3/5/6")]
    let currentEventsImages = [UIImage(named: "Logo2"), UIImage(named: "HomeIcon"), UIImage(named: "Logo2"), UIImage(named: "CalendarIcon"), UIImage(named: "HomeIcon")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentEventsTableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return currentEventsTitles.count

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "currentEventsCell", for: indexPath as IndexPath) as! CurrentEventsCell

        cell.photoImageView?.image = currentEventsImages[indexPath.item]
        cell.nameLabel?.text = currentEventsTitles[indexPath.item]
        cell.dateLabel?.text = currentEventsDates[indexPath.item]

        return cell
    }


    
}

class CurrentEventsCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
}
