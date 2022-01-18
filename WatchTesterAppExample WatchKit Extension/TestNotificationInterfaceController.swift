//
//  TestNotificationInterfaceController.swift
//  WatchTesterAppExample WatchKit Extension
//
//  Created by Zhanna Moskaliuk on 04.01.2022.
//

import WatchKit
import Foundation

class TestNotificationInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var checkLocationButton: WKInterfaceButton!
    @IBOutlet weak var locationLabel: WKInterfaceLabel!
    
    @IBAction func checkLocation() {
        updateLocation()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        self.checkLocationButton.setAccessibilityIdentifier("check_location")
//        self.locationLabel.setText("left")
        
        //        Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { [weak self] (_) in
        //            self?.updateLocation()
        //        }
    }
    
    dynamic func updateLocation() {
        let location = WKInterfaceDevice.current().wristLocation
        switch location {
        case .left:
            self.locationLabel.setText("left")
        case .right:
            self.locationLabel.setText("right")
        @unknown default:
            self.locationLabel.setText("unknown")
        }
    }
}
