//
//  ViewController.swift
//  WatchTesterAppExample
//
//  Created by Zhanna Moskaliuk on 02.11.2021.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {

    @IBOutlet weak var testSwitch: UISwitch!
    
    private var selected = false
    
    @IBAction func switchAcrion(_ sender: UISwitch) {
        selected.toggle()
        sendMessage(message: selected ? "selected" : "unselected")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
   private func sendMessage(message: String) {
        if (WCSession.default.isReachable) {
            let messDict = ["Message" : message]
            WCSession.default.sendMessage(messDict, replyHandler: nil)
        }
    }
}

extension ViewController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        //
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //
    }
}
