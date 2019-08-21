//
//  ViewController.swift
//  Leader
//
//  Created by Taryn Neal on 7/23/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//
//import JTAppleCalendar
import UIKit

//class DateCell: JTACDayCell {
//
//    @IBOutlet var dateLabel: UILabel!
//
//}

//class CalendarVC : UIViewController, JTACMonthViewDelegate, JTACMonthViewDataSource {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       // var variable : String = "yayagaga"
//        // Do any additional setup after loading the view.
//       // navigationController?.navigationBar.topItem?.hidesBackButton = true
//
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        navigationController?.navigationBar.topItem?.hidesBackButton = true
//        //Only works when click back into tab- not quite right
//    }
////
////    func configureCell(view: JTACDayCell?, cellState: CellState) {
////        guard let cell = view as? DateCell  else { return }
////        cell.dateLabel.text = cellState.text
////        handleCellTextColor(cell: cell, cellState: cellState)
////    }
////
////    func handleCellTextColor(cell: DateCell, cellState: CellState) {
////        if cellState.dateBelongsTo == .thisMonth {
////            cell.dateLabel.textColor = UIColor.black
////        }
////        else {
////            cell.dateLabel.textColor = UIColor.gray
////        }
////    }
////    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
////
////        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
////        cell.dateLabel.text = cellState.text
////        return cell
////        //        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
////
////
////    }
////    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
////
////        let cell = cell as! DateCell
////        cell.dateLabel.text = cellState.text
////        // configureCell(view: cell, cellState: cellState)
////
////    }
////    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
////
////        let formatter = DateFormatter()
////        formatter.dateFormat = "yyyy MM dd"
////        let startDate = formatter.date(from: "2019 01 01")!
////        let endDate = Date()
////        return ConfigurationParameters(startDate: startDate, endDate: endDate)
////
////    }
//}
//
////extension CalendarVC: JTACMonthViewDataSource {
////
////    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
////
////        let formatter = DateFormatter()
////        formatter.dateFormat = "yyyy MM dd"
////        let startDate = formatter.date(from: "2019 01 01")!
////        let endDate = Date()
////        return ConfigurationParameters(startDate: startDate, endDate: endDate)
////
////    }
////
////}
////
////extension CalendarVC : JTACMonthViewDelegate {
////
////    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
////
////        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
////        cell.dateLabel.text = cellState.text
////        return cell
//////        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
////
////
////    }
////    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
////
////        let cell = cell as! DateCell
////        cell.dateLabel.text = cellState.text
////       // configureCell(view: cell, cellState: cellState)
////
////    }
////}
//
