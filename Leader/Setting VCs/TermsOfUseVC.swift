//
//  TermsOfUseVC.swift
//  Leader
//
//  Created by Taryn Neal on 1/14/20.
//  Copyright © 2020 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit

class TermsOfUseVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var titles : [String] = ["A. Images", "B. Libraries & Backend Software", "C. Privacy"]
    var details : [String] = ["The logo for Leader was made by the developer, as well as the icons for the tab bars, and settings icons. The logos for FBLA, Twitter, Facebook, and Instagram all belong to the respective entities and not the developer. They were merely used to direct traffic towards said applications.", "A variety of open source libraries were used in Leader, as well as Firebases Spark Plan. Firebase was used as the backend for this application, and while the data stored on Firebase is Leader’s, Firebase and it’s software belongs to google. JTAppleCalender was used as a basis for this applications calendar functionality, however the GUI, integration with firebase, and display of event details were all done by the developer of Leader. SVProgressHUD was used to ease the users worries over Firebase’s slow load time, but belongs to its developer.", "Leader takes privacy very seriously. We cannot view your passwords, nor can we access personal data about you on your phone without your consent. The only information available to us is basic info given to us by you."]
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 40.0
        tableView.separatorStyle = .none

       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "licensingCell", for: indexPath as IndexPath)as! LicensingCell
        
        cell.label.text = titles[indexPath.row]
        cell.details.text = details[indexPath.row]

        return cell
    }
    
    
}

class LicensingCell : UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var details: UILabel!
}
