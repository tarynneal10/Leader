//
//  CurrentEventsVC.swift
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
//import FirebaseUI

class CurrentEventsVC : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var noCurrentEvents: UIImageView!
    @IBOutlet var currentEventsTableView: UITableView!

    var db: Firestore!
    var DocRef : Query?
    var userRef : Query?
    var list: [CurrentEvent] = []
    var chapterName = ""
    var receivedString = ""
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy"
        return formatter
    }



override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        navigationItem.title = receivedString
        SVProgressHUD.show()
        
    
        currentEventsTableView.estimatedRowHeight = 125.0
        currentEventsTableView.rowHeight = UITableView.automaticDimension
}
override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        noCurrentEvents.isHidden = true
        currentEventsTableView.isHidden = false
        getUser()
        currentEventsTableView.reloadData()
}
    
    func gradient(frame:CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.colors = [
        UIColor.blue.cgColor,UIColor.yellow.cgColor]
        return layer
    }
    
    func emptyArray() {
        noCurrentEvents.isHidden = false
        currentEventsTableView.isHidden = true
        print("no events present")
    }
//MARK: Retrieving from cloud
    func getUser() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        userRef = db.collection("members").whereField("user UID", isEqualTo: userID)
        userRef?.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                self.emptyArray()
                //Put more error handling here
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let chapter = document.get("chapter") as? String
                    self.chapterName = chapter!
                    self.DocRef = self.db.collection("currentevents").whereField("chapter", isEqualTo: self.chapterName)
                    
                }
                self.list = self.createArray()
            }
        }
    }
    
    func createArray() -> [CurrentEvent] {
        DocRef?.getDocuments() { (QuerySnapshot, err) in
                if err != nil {
                    print("Error getting documents: \(String(describing: err))")
                    self.emptyArray()
                    SVProgressHUD.dismiss()
                } else {
                    self.list.removeAll()
                    for document in QuerySnapshot!.documents {
                        
                        let name = document.get("name") as? String
                        let date = document.get("date") as? String
                        let description = document.get("description") as? String
                        let time = document.get("time") as? String
                        
                        //Checks to see if event before today's date
                        let eventDate = self.formatter.date(from: date!)
                        
                            if eventDate! >= Date() {
                                self.list.append(CurrentEvent(eventName: name!, eventDate: date!, eventDescription: description!, eventTime: time!))
                                print(document.data())
                            }
                        
                    }
                    self.list = self.list.sorted(by: {$0.date.localizedStandardCompare($1.date) == .orderedAscending})

                    if self.list.isEmpty == true {
                        self.emptyArray()
                    }
                    SVProgressHUD.dismiss()
                    self.currentEventsTableView.reloadData()
                }
  
        }

        return list
    }

    
//MARK: Table View Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentEventsCell", for: indexPath as IndexPath) as! CurrentEventsCell
            let listPath = list[indexPath.row]
            cell.populate(currentEvent: listPath)
                if indexPath.row % 2 == 1 {
                    cell.backgroundColor = UIColor(red: 230, green: 230, blue: 230)
                } else {
                    //cell.backgroundColor = UIColor(red: 5, green: 63, blue: 94)
                }
            return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    //Unwinds from add event
    @IBAction func unwindToCurrentEvents(segue: UIStoryboardSegue) {}
}

//MARK: CurrentEventsCell Class
class CurrentEventsCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func populate(currentEvent: CurrentEvent) {
        nameLabel.text = currentEvent.name
        dateLabel.text = currentEvent.date
        descriptionLabel.text = currentEvent.description
        timeLabel.text = currentEvent.time
    }

}

