//
//  SettingsViewController.swift
//  Leader
//
//  Created by Taryn Neal on 7/23/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit

class SettingsVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    let settingsCellLabelArray = ["Security", "Q&A", "Contact Us", "Bug Report", "Log Out"]
    let settingsCellImageArray = [UIImage(named: "Logo2"), UIImage(named: "HomeIcon"), UIImage(named: "Logo2"), UIImage(named: "BugIcon"), UIImage(named: "HomeIcon")]

    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.image = UIImage(named: "Logo2")
        //nameLabel.text = ""
        // Do any additional setup after loading the view.
//        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
//        navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        settingsTableView.reloadData()
        //self.navigationItem.setHidesBackButton(true, animated: true)
//        self.navigationItem.setLeftBarButtonItems(nil, animated: true)
//        self.navigationItem.setHidesBackButton(true, animated:true)
        //self.navigationItem.setHidesBackButton(true, animated: false)
        //code commented out in did load and appear more for when activating push segue in code- for later
        //navigationController?.navigationBar.topItem?.hidesBackButton = true

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsCellLabelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsTableCell
        
        cell.settingsCellLabel?.text = settingsCellLabelArray[indexPath.item]
        cell.settingsCellImage?.image = settingsCellImageArray[indexPath.item]

        return cell
    }
}
class SettingsTableCell : UITableViewCell {
    @IBOutlet weak var settingsCellLabel: UILabel!
    @IBOutlet weak var settingsCellImage: UIImageView!
}
