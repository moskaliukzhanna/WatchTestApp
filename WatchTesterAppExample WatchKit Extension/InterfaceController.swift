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
    @IBOutlet weak var messageLabel: WKInterfaceLabel!
    
    @IBAction func goToTable() {
        self.pushController(withName: "EventTableInterfaceController", context: nil)
    }
    
    override func awake(withContext context: Any?) {
        tableButton.setAccessibilityIdentifier("table_button")
        kittyImage.setImageNamed("studyCat")
        kittyImage.setTintColor(.black)
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
        WKInterfaceDevice().play(.click)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let value = message["Message"] as? String {
            if value == "selected" || value == "unselected" {
            kittyImage.setImageNamed(value == "selected" ? "studyCat" : "funnyCat")
            } else {
                messageLabel.setText(value)
            }
        }
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        //
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        //
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        //
    }
    
    func sessionCompanionAppInstalledDidChange(_ session: WCSession) {
        //
    }
}
