//
//  Event.swift
//  Get Together
//
//  Created by Cam Weston on 4/25/19.
//  Copyright © 2019 Liam O’Toole. All rights reserved.
//

import Foundation
class Event {
    var id : String!
    var title: String!
    var longitude: Double!
    var latitude: Double!
    var address: String!
    var createdBy: String!
    
    init(id:String, title:String, longitude:Double, latitude:Double, address:String, createdBy:String) {
        self.id = id
        self.title = title
        self.longitude = longitude
        self.latitude = latitude
        self.address = address
        self.createdBy = createdBy
    }
}
