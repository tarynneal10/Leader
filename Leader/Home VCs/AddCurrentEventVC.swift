//
//  AddCurrentEventVC.swift
//  Leader
//
//  Created by Taryn Neal on 9/16/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddEventVC : UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    var db: Firestore!
    var userRef : Query?
    var chapterName = ""
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        getUser()
        datePicker.isHidden = true
        doneButton.isHidden = true
   
    }
    
      func errorAlert() {
          let alert = UIAlertController(title: "Error", message: "Please enter all the event information", preferredStyle: .alert)
          
          let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { (UIAlertAction) in
    
          })
          
          alert.addAction(tryAgainAction)
          
          self.present(alert, animated: true, completion: nil)
      }
    
//MARK: Retrieving from cloud
    
      func getUser() {
          if Auth.auth().currentUser != nil {
              // User is signed in.
              let userID = Auth.auth().currentUser?.uid
              userRef = db.collection("members").whereField("user UID", isEqualTo: userID!)
              userRef?.getDocuments() { (querySnapshot, err) in
                  if let err = err {
                      print("Error getting documents: \(err)")
                      //Put more error handling here
                  } else {
                      for document in querySnapshot!.documents {
                          print("\(document.documentID) => \(document.data())")
                          let chapter = document.get("chapter") as? String
                          self.chapterName = chapter!
                      }
                  }
              }
          } else {
              // No user is signed in.
              print("User not signed in")
          }

      }
      func addToFirestore() {
          
                  var ref: DocumentReference? = nil
                  ref = db.collection("currentevents").addDocument(data: [
                      "name": titleText.text!,
                      "description": descriptionText.text!,
                      "date": dateTF.text!,
                      "chapter": chapterName
                  ]) { err in
                      if let err = err {
                          print("Error adding document: \(err)")
                      } else {
                          print("Document added with ID: \(ref!.documentID)")
                          
                      }
                  }
          
      }
    
//MARK: Text field functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    //UITextView return
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        descriptionText.text = textView.text
            
        if text == "\n" {
            textView.resignFirstResponder()
                
            return false
        }
            
        return true
    }
//MARK: IBAction functions
    
    @IBAction func dateTFPressed(_ sender: Any) {
        dateTF.isHidden = true
        datePicker.isHidden = false
        doneButton.isHidden = false
    }
    @IBAction func donePressed(_ sender: Any) {
        datePicker.isHidden = true
        dateTF.isHidden = false
        doneButton.isHidden = true
        dateTF.text = formatter.string(from: datePicker.date)
        
    }
    @IBAction func createEventPressed(_ sender: Any) {
        if titleText.text != "", descriptionText.text != "", dateTF.text != ""
        {
            addToFirestore()
            dismiss(animated: true, completion: nil)
            
        } else {
            errorAlert()
        }
    }
}
