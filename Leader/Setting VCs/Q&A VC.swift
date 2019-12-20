//
//  Q&A VC.swift
//  Leader
//
//  Created by Taryn Neal on 12/20/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit

class QATableViewController : UITableViewController {
    var sectionTitles = ["Usage", "Passwords", "Bugs"]
    var sectionInfo = [["Use it", "Don't be a fool"], ["How can I reset my password?", "Why is my password not working", "Someone stole my password"], ["Why does the app keep crashing?", "Why are the designs this way?", "Why isn't there more functionality?"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
            return sectionTitles[section]
    
        }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
            return sectionTitles.count
    
        }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return sectionInfo[section].count
        }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath as IndexPath) as! QuestionCell
            
            cell.label.text = sectionInfo[indexPath.section][indexPath.row]
            
            return cell
        }
}
class QuestionCell : UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
}
