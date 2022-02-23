//
//  WristLocationInterfaceController.swift
//  WatchTesterAppExample WatchKit Extension
//
//  Created by Zhanna Moskaliuk on 04.02.2022.
//

import WatchKit
import Foundation


class WristLocationInterfaceController: WKInterfaceController {

    @IBOutlet weak var wristLocationLabel: WKInterfaceLabel!
    @IBOutlet weak var checkWristLocationButton: WKInterfaceButton!
    
    @IBAction func checkWristLocation() {
        checkLocation()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        wristLocationLabel.setText("left")
        wristLocationLabel.setAccessibilityIdentifier("wrist_location")
        checkWristLocationButton.setAccessibilityIdentifier("check_wristLocation")
    }
    
    private func checkLocation() {
        let location = WKInterfaceDevice.current().wristLocation
        switch location {
        case .left:
            wristLocationLabel.setText("left")
        case .right:
            wristLocationLabel.setText("right")
        @unknown default:
            wristLocationLabel.setText("unknown")
        }
    }
}
