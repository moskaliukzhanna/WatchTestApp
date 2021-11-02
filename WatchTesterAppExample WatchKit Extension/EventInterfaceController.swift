//
//  EventInterfaceController.swift
//  WatchTesterAppExample WatchKit Extension
//
//  Created by Zhanna Moskaliuk on 02.11.2021.
//

import WatchKit
import Foundation


class EventInterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
