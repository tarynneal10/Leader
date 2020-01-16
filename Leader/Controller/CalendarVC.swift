//
//  ViewController.swift
//  Leader
//
//  Created by Taryn Neal on 7/23/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import JTAppleCalendar
import UIKit
import Firebase
import SVProgressHUD

class DateCell: JTACDayCell {
    @IBOutlet var dotView: UIView!
    @IBOutlet var selectedView: UIView!
    @IBOutlet var dateLabel: UILabel!
    
}
class DateHeader: JTACMonthReusableView  {
    @IBOutlet var monthTitle: UILabel!
   
}
class CalendarVC : UIViewController{
    @IBOutlet var calendarView: JTACMonthView!
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var noEventsLabel: UILabel!
    
    var db: Firestore!
    var DocRef : Query?
    var userRef : Query?
    var chapterName : String?
    var calendarDataSource: [String : String] = [:]
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }
    let monthFormatter = DateFormatter()
    var selectedDate : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedDate = formatter.date(from: "01/00/0000")
        monthFormatter.dateFormat = "MMMM"
        db = Firestore.firestore()
        getUser()
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        backgroundLabel.isHidden = true
        nameLabel.isHidden = true
        dateLabel.isHidden = true
        descriptionLabel.isHidden = true
        noEventsLabel.isHidden = true
        //SVProgressHUD.show()- because it's annoying
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
                    self.chapterName = document.get("chapter") as? String
                    self.navigationItem.title = self.chapterName
                    self.DocRef = self.db.collection("currentevents").whereField("chapter", isEqualTo: self.chapterName!)
                    
                }
                self.populateDataSource()
                
            }
        }
    }
    func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? DateCell  else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellEvents(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
    }
    
    func handleCellSelected(cell: DateCell, cellState: CellState) {
        let dateString = formatter.string(from: cellState.date)
        
        if cellState.isSelected {
            cell.selectedView.layer.cornerRadius =  13
            cell.selectedView.isHidden = false
            backgroundLabel.isHidden = false
            
            if calendarDataSource[dateString] == nil {
                noEventsLabel.isHidden = false
                nameLabel.isHidden = true
                dateLabel.isHidden = true
                descriptionLabel.isHidden = true
            } else {

                nameLabel.isHidden = false
                dateLabel.isHidden = false
                descriptionLabel.isHidden = false
                noEventsLabel.isHidden = true
                displayDetails()
            }
            
            print("Cell selected")
            
        } else {
            cell.selectedView.isHidden = true
        }
    }

    //Displays details in yellow box- WARNING- only displays if time is 12 AM. Need to fix.
   func displayDetails() {
        if selectedDate != formatter.date(from: "01/00/0000") {
            let date = formatter.string(from: selectedDate!)
            let DateRef = db.collection("currentevents")
                .whereField("chapter", isEqualTo: chapterName!)
                .whereField("date", isEqualTo: date)

            DateRef.getDocuments(){ (QuerySnapshot, err) in
                    if err != nil
                    {
                        print("Error getting documents: \(String(describing: err))");
                    } else {

                        for document in QuerySnapshot!.documents {
                            self.nameLabel.text = document.get("name") as? String
                            self.dateLabel.text = document.get("date") as? String
                            self.descriptionLabel.text = document.get("description") as? String

                            print(document.data())

                        }
                    }

            }
        } else {
          print("selectedDate has no value")
        }
    }
    func populateDataSource() {
        DocRef?.getDocuments()
        { (QuerySnapshot, err) in
            if err != nil
            {
                print("Error getting documents: \(String(describing: err))");
            }
            else
            {
                for document in QuerySnapshot!.documents {
                    let date = document.get("date") as? String
                    self.calendarDataSource[date!] = "Idk"
                    print(document.data())
                }
                //SVProgressHUD.dismiss()
                self.calendarView.reloadData()
                
            }
        }

        
        
    }
    func handleCellEvents(cell: DateCell, cellState: CellState) {
            let dateString = formatter.string(from: cellState.date)
            if calendarDataSource[dateString] == nil {
                cell.dotView.isHidden = true

            } else {
                cell.dotView.isHidden = false
            }
        }

    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = UIColor.yellow
        } else {
            cell.dateLabel.textColor = UIColor.gray
        }
    }
  func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
       let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthTitle.text = monthFormatter.string(from: range.start)
       return header
    
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }

}
extension CalendarVC: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        
        let startDate = Date()
        let endDate = dateFormatter.date(from: "2020 06 30")!
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}
extension CalendarVC: JTACMonthViewDelegate {
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {

        selectedDate = date
        configureCell(view: cell, cellState: cellState)
        
     }
     func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
         configureCell(view: cell, cellState: cellState)
     }

}
