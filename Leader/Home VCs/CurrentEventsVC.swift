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
    
@IBOutlet var currentEventsTableView: UITableView!

var db: Firestore!
var DocRef : Query?
var userRef : Query?
var list: [CurrentEvent] = []
var chapterName = ""
var receivedString = ""
var formatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    return formatter
}

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        db = Firestore.firestore()
        navigationItem.title = receivedString
        SVProgressHUD.show()
        
        currentEventsTableView.estimatedRowHeight = 125.0
        currentEventsTableView.rowHeight = UITableView.automaticDimension
        
        getUser()
        currentEventsTableView.reloadData()
    }

//MARK: Retrieving from cloud
    
    func createArray() -> [CurrentEvent]
    {
        DocRef?.getDocuments()
            { (QuerySnapshot, err) in
                if err != nil
                {
                    print("Error getting documents: \(String(describing: err))");
                    SVProgressHUD.dismiss()
                }
                else
                {
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
                    SVProgressHUD.dismiss()
                    self.currentEventsTableView.reloadData()
                }
  
        }

        return list
    }
    func getUser() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        userRef = db.collection("members").whereField("user UID", isEqualTo: userID)
        userRef?.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
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
    
//MARK: Table View Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentEventsCell", for: indexPath as IndexPath) as! CurrentEventsCell
            let listPath = list[indexPath.row]
            cell.populate(currentEvent: listPath)
        
            return cell
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

