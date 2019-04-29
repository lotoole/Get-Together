//
//  SingleEventController.swift
//  Get Together
//
//  Created by Liam O'Toole on 4/29/19.
//  Copyright © 2019 Liam O'Toole. All rights reserved.
//

import UIKit

class SingleEventController: UIViewController {
    var eventId: String!
   
    @IBOutlet weak var TitleOutlet: UILabel!
    @IBOutlet weak var AddressOutlet: UILabel!
    @IBOutlet weak var DescriptionOutlet: UILabel!
    @IBOutlet weak var TimeOutlet: UILabel!
    @IBOutlet weak var HostedByOutlet: UITextView!
    
    
    
    override func viewDidLoad() {
        
        print("Liams", eventId)
    }
    
    func renderSingleEventView(event: Event) {
        //set all the outlet variables text to the event objects information
        TitleOutlet.text = event.title
        AddressOutlet.text = event.address
    }
    
}
