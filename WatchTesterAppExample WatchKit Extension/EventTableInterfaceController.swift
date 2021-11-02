//
//  EventTableInterfaceController.swift
//  WatchTesterAppExample WatchKit Extension
//
//  Created by Zhanna Moskaliuk on 02.11.2021.
//

import WatchKit
import Foundation


class EventTableInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    var events = Event.allEvents()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        table.setNumberOfRows(events.count, withRowType: "AWCell")
        table.setIsAccessibilityElement(false)
        table.setAccessibilityIdentifier("onboardingTable")
        
        for index in 0..<table.numberOfRows {
          guard let controller = table.rowController(at: index) as? AWEventRowController else { continue }

          controller.event = events[index]
        }
    }
}
