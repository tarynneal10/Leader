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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        DocRef = db.collection("currentevents").whereField("chapter", isEqualTo: "Marysville Getchell")

        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode   = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        populateDataSource()
    }
    var calendarDataSource: [String:String] = [:]
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter
    }
    func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? DateCell  else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellEvents(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
       // calendarView.reloadData()
    }
    
    func handleCellSelected(cell: DateCell, cellState: CellState) {
        if cellState.isSelected {
            cell.selectedView.layer.cornerRadius =  13
            cell.selectedView.isHidden = false
        } else {
            cell.selectedView.isHidden = true
        }
    }

    func populateDataSource() {
        // You can get the data from a server.
//        DocRef?.getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//                //Put more error handling here
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                   // self.calendarDataSource = ["\(String(describing: document.get("date")))": "data"]
//                }
//            }
//        }
        // Then convert that data into a form that can be used by the calendar.
        calendarDataSource = [
            "07-Jan-2019": "SomeData",
            "15-Jan-2019": "SomeMoreData",
            "15-Feb-2019": "MoreData",
            "21-Feb-2019": "onlyData",
        ]
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
    
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = UIColor.yellow
        } else {
            cell.dateLabel.textColor = UIColor.gray
        }
    }
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let monthFormatter = DateFormatter()  // Declare this outside, to avoid instancing this heavy class multiple times.
        monthFormatter.dateFormat = "MMMM"
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
        
        let startDate = dateFormatter.date(from: "2019 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
//        return ConfigurationParameters(startDate: startDate,
//                                       endDate: endDate,
//                                       generateInDates: .forAllMonths,
//                                       generateOutDates: .tillEndOfGrid)
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
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
}
