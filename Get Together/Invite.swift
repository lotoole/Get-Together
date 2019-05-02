//
//  Invite.swift
//  Get Together
//
//  Created by Liam O'Toole on 5/1/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//

import Foundation
class Invite {
    var to : String!
    var from : String!
    var eventId: String!
    
    init(to:String, from:String, eventId:String) {
        self.to = to
        self.from = from
        self.eventId = eventId
    }
}
