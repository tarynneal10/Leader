//
//  Attendance.swift
//  Leader
//
//  Created by Taryn Neal on 1/13/20.
//  Copyright © 2020 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SVProgressHUD

class AttendanceViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
     var db: Firestore!
     var DocRef : Query?
     var userRef : Query?
     //var members : [Member] = []
     var members : [String] = [""]
     var chapterName = ""
     var values = [String]()
     
    override func viewDidLoad() {
            super.viewDidLoad()
            db = Firestore.firestore()
            
            tableView.delegate = self
            tableView.dataSource = self
            
            getUser()
    }
    override func viewDidDisappear(_ animated: Bool) {
        //Getting label values
        for (index, value) in members.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                guard let cell = tableView.cellForRow(at: indexPath) as? AttendanceTableViewCell else { return }
            if let text = cell.label.text, !text.isEmpty, cell.checkmark == true {
                values.append(value)
            }
        }
        print("Values: \(values)")
    }
//MARK: Retrieving from cloud
    //Gets user for other queries
    func getUser() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        userRef = db.collection("members").whereField("user UID", isEqualTo: userID)
        userRef?.getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
                        //Put more error handling here
        } else {
            for document in querySnapshot!.documents {
               // print("\(document.documentID) => \(document.data())")
                let chapter = document.get("chapter") as? String
                self.chapterName = chapter!
                self.navigationItem.title = self.chapterName
                self.DocRef = self.db.collection("members").whereField("chapter", isEqualTo: self.chapterName).whereField("paid", isEqualTo: true)
            }
            self.getMembers()
        }
    }
    }
    //Gets members for tableView
    func getMembers() {
            DocRef?.getDocuments() { (QuerySnapshot, err) in
                if err != nil
                {
                    print("Error getting documents: \(String(describing: err))");
                }
                else
                {
                    if let snapshot = QuerySnapshot {
                        self.members.removeAll()
                        for document in snapshot.documents {
                            let name = document.get("name") as? String
                            self.members.append(name!)
                            //print(document.data())
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
                
            }
    }
    
//MARK: Table View Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "attendanceCell", for: indexPath as IndexPath)as! AttendanceTableViewCell
    
             cell.label.text = members[indexPath.row]

             return cell
    }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: true)
        }
    //This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let viewController = segue.destination as? MeetingMinutesVC
            //This isn't passing for some reason
            viewController?.passedValues = values
    }


}

//MARK: AttendanceTableViewCell Class

class AttendanceTableViewCell : UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var checkmark : Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkmark = false
    }
    @IBAction func buttonPressed(_ sender: Any) {
        if checkmark == false {
            button.setImage(UIImage(named: "Checkmark"), for: .normal)
            checkmark = true
        } else {
            button.setImage(UIImage(named: "Nothing"), for: .normal)
            checkmark = false
        }
    
    }
    
}
