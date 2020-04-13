//
//  Q&A VC.swift
//  Leader
//
//  Created by Taryn Neal on 12/20/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit

class QAViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var QATableView: UITableView!
  
    var sectionTitles = ["Events", "Membership"]
    var sectionInfo = [["How do I add competitive events?", "How do I delete my signed up events?"], ["How do I become a paid member?"]]
    var viewController : QADetailsVC?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        QATableView.delegate = self
        QATableView.dataSource = self
        

        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionInfo[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath as IndexPath) as! QuestionCell
        
        cell.label.text = sectionInfo[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as! QuestionCell
        tableView.deselectRow(at: indexPath!, animated: true)
        
        let valueToPass = currentCell.label.text
        viewController?.passedValue = valueToPass!
        print(valueToPass as Any)
      
    }
    //  This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        viewController = segue.destination as? QADetailsVC
    }
    
}
class QuestionCell : UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
}
