//
//  ArchiveVC.swift
//  Leader
//
//  Created by Taryn Neal on 3/8/20.
//  Copyright © 2020 Taryn Neal. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class ArchiveVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noMinutes: UIImageView!
    
    var db: Firestore!
    var meetings = [""]
    
    var userRef : Query?
    var docRef : Query?
    
    var chapterName = ""
    var valueToPass = ""
    var viewController : ArchiveDetailsVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        noMinutes.isHidden = true
        tableView.isHidden = false
        
        getUser()
    }
    func noMinutesPresent() {
         noMinutes.isHidden = false
         tableView.isHidden = true
     }
    
    //Gets user for other queries
    func getUser() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        userRef = db.collection("members").whereField("user UID", isEqualTo: userID)
        
        userRef?.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                self.noMinutesPresent()
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let chapter = document.get("chapter") as? String
                    self.chapterName = chapter!
                    self.navigationItem.title = self.chapterName
                    self.docRef = self.db.collection("minutes").whereField("chapter", isEqualTo: self.chapterName)
                }
                self.getMeetings()
            }
        }
    }
    
    //Gets meeting dates for tableView
    func getMeetings() {
            docRef?.getDocuments() { (querySnapshot, err) in
                if err != nil {
                    print("Error getting documents: \(String(describing: err))")
                    self.noMinutesPresent()
                }
                else {
                    self.meetings.removeAll()
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                            
                        let date = document.get("date") as? String
                        self.meetings.append(date!)
                    }
                    
                    if self.meetings.isEmpty == true {
                        self.noMinutesPresent()
                        print("no minutes")
                    }
                    self.tableView.reloadData()
                    
                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                 let cell = tableView.dequeueReusableCell(withIdentifier: "archiveCell", for: indexPath as IndexPath) as! ArchiveCell
        
                 cell.label.text = "\(meetings[indexPath.row])"

                 return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as! ArchiveCell
        tableView.deselectRow(at: indexPath!, animated: true)
        
        //Set valueToPass
        valueToPass = currentCell.label.text!
        viewController?.passedValue = valueToPass
        print(valueToPass)
      
    }
    //  This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        viewController = segue.destination as? ArchiveDetailsVC
    }
}

class ArchiveCell : UITableViewCell {
    @IBOutlet weak var label: UILabel!
}
