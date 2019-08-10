//
//  CompetitiveEvents.swift
//  Todoey
//
//  Created by Taryn Neal on 8/9/19.
//  Copyright © 2019 Taryn Neal. All rights reserved.
//

import Foundation

class CompetitiveEvent {

    let eventName : String
    let eventType : String
    let eventCategory : String

    init(name : String, type : String, category : String) {
        eventName = name
        eventType = type
        eventCategory = category
        
    }
}

class CompetitiveEventsBank {
    var events = [CompetitiveEvent]()
    init() {
        events.append(CompetitiveEvent(name: "", type: "", category: ""))
    }
}
