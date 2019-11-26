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

class DateCell: JTACDayCell {
    @IBOutlet var dotView: UIView!
    @IBOutlet var selectedView: UIView!
    @IBOutlet var dateLabel: UILabel!
    
}
class DateHeader: JTACMonthReusableView  {
    @IBOutlet var monthTitle: UILabel!
   
}
class CalendarVC : UIViewController {
    @IBOutlet var calendarView: JTACMonthView!
    var db: Firestore!
    var DocRef : Query?
    var userRef : Query?
    var chapterName = ""
    var calendarDataSource: [String : String] = [:]
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter
    }
    let monthFormatter = DateFormatter()
    var dataReceived = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monthFormatter.dateFormat = "MMMM"
        db = Firestore.firestore()
        getUser()
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
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
                    self.navigationItem.title = self.chapterName
                    self.DocRef = self.db.collection("currentevents").whereField("chapter", isEqualTo: self.chapterName)

                }
                self.populateDataSource()
                self.dataReceived = true
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
        if cellState.isSelected {
            cell.selectedView.layer.cornerRadius =  13
            cell.selectedView.isHidden = false
            print("Cell selected")
        } else {
            cell.selectedView.isHidden = true
        }
    }

    func populateDataSource() {
        // You can get the data from a server.
        DocRef?.getDocuments()
        { (QuerySnapshot, err) in
            if err != nil
            {
                print("Error getting documents: \(String(describing: err))");
            }
            else
            {
                for document in QuerySnapshot!.documents {
                    let date = document.get("date") as? Timestamp
                    let append = self.formatter.string(from: (date?.dateValue())!)
                    self.calendarDataSource[append] = "Idk"
                    print(document.data())
                }
            }

        }

        // update the calendar
        calendarView.reloadData()
    }
        func handleCellEvents(cell: DateCell, cellState: CellState) {
            let dateString = formatter.string(from: cellState.date)
            if calendarDataSource[dateString] == nil {
                cell.dotView.isHidden = true

            } else {
                cell.dotView.isHidden = false
            }
        }
//
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
        print("Cells Displayed")
        //Once more, we run into the problem of the cells being displayed before I get the data from the cloud- how to fix?
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
         configureCell(view: cell, cellState: cellState)
     }
     func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
         configureCell(view: cell, cellState: cellState)
     }

}
