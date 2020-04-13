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
    let date : String
    let description : String
    let time : String
    
    init (eventName: String, eventDate: String, eventDescription: String, eventTime: String) {
        name = eventName
        date = eventDate
        description = eventDescription
        time = eventTime
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
    let paid : Bool
    let docID : String
    
    init (memberName: String, memberPaid: Bool, memberDoc: String) {
        name = memberName
        paid = memberPaid
        docID = memberDoc
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

class Archive {
    let date : String
    let subject : String
    init(meetingDate: String, meetingSubject: String) {
        date = meetingDate
        subject = meetingSubject
    }
}

class Question {
    let question : String
    let answer : String
    let section : String
    init(questions: String, answers: String, sections: String) {
        question = questions
        answer = answers
        section = sections
    }
}
