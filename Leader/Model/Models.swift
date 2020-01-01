//
//  SettingsTableModel.swift
//  Leader
//
//  Created by Taryn Neal on 8/2/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class CurrentEvent {
    
    let name : String
    let date : Timestamp
    let description : String
    
    init (eventName: String, eventDate: Timestamp, eventDescription: String) {
        name = eventName
        date = eventDate
        description = eventDescription
    }
    
}

class CurrentEventDate {
    let date : String
    init (eventDate: String) {
        date = eventDate
    }
}

class Member {
    let name : String
    
    init (memberName: String) {
        name = memberName
    }
}

class CompetitiveEvent {
    let name : String
    let category : String
    let type : String
    init (eventName: String, eventCategory: String, eventType: String) {
        name = eventName
        category = eventCategory
        type = eventType
    }
}
class Chapter {
    let name : String
    init(chapterName: String){
        name = chapterName
    }
}

class Minutes {
    let label : String
    init(title: String){
        label = title
    }
}
