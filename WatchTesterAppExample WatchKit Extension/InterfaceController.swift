//
//  InterfaceController.swift
//  WatchTesterAppExample WatchKit Extension
//
//  Created by Zhanna Moskaliuk on 02.11.2021.
//

import WatchKit
import WatchConnectivity
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var tableButton: WKInterfaceButton!
    @IBOutlet weak var kittyImage: WKInterfaceImage!
    
    @IBAction func goToTable() {
        
    }
    

    override func awake(withContext context: Any?) {
        tableButton.setAccessibilityIdentifier("table_button")
        kittyImage.setImageNamed("studyCat")
    }
    
    override func willActivate() {
        super.willActivate()
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
}

extension InterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    
}
