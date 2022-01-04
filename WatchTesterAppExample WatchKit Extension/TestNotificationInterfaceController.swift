//
//  TestNotificationInterfaceController.swift
//  WatchTesterAppExample WatchKit Extension
//
//  Created by Zhanna Moskaliuk on 04.01.2022.
//

import WatchKit
import Foundation
import UserNotifications


class TestNotificationInterfaceController: WKInterfaceController {

    @IBOutlet weak var locationLabel: WKInterfaceLabel!
    
    @IBAction func showNotification() {
        let action1 = UNNotificationAction(identifier: "action_1",
                                           title: "Action 1",
                                           options: UNNotificationActionOptions(rawValue: 0))
        let action2 = UNNotificationAction(identifier: "action_2",
                                           title: "Action 2",
                                           options: UNNotificationActionOptions(rawValue: 0))
        let testCategory = UNNotificationCategory(identifier: "test_category",
                                                  actions: [action1, action2],
                                                  intentIdentifiers: [],
                                                  options: .customDismissAction)
        UNUserNotificationCenter.current().setNotificationCategories([testCategory])

        let content = UNMutableNotificationContent()
        content.title = "Test Notification"
        content.categoryIdentifier = testCategory.identifier
        let request = UNNotificationRequest(identifier: "test_notification",
                                            content: content,
                                            trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        UNUserNotificationCenter.current().delegate = self
        
        self.updateLocation()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (_) in
            self?.updateLocation()
        }
    }
    
    private func updateLocation() {
        switch WKInterfaceDevice.current().wristLocation {
        case .left:
            self.locationLabel.setText("left")
        case .right:
            self.locationLabel.setText("right")
        @unknown default:
            self.locationLabel.setText("unknown")
        }
    }
}

extension TestNotificationInterfaceController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .alert])
    }
}
