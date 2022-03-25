//
//  EventInterfaceController.swift
//  WatchTesterAppExample WatchKit Extension
//
//  Created by Zhanna Moskaliuk on 02.11.2021.
//

import WatchKit
import Foundation


class EventInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var eventImage: WKInterfaceImage!
    @IBOutlet weak var eventCategory: WKInterfaceLabel!
    @IBOutlet weak var eventLabel: WKInterfaceLabel!
    @IBOutlet weak var longPressGesture: WKLongPressGestureRecognizer!
    var pushWristLocationScreen = false
    
    @IBAction func longPress(_ sender: Any) {
        goToWristLocationScreen()
    }
    
    var event: Event? {
        didSet {
            guard let event = event else { return }
            eventLabel.setText(event.name)
            eventCategory.setText(event.category?.rawValue)
            eventImage.setImage(event.category?.eventImage)
            eventImage.setTintColor(event.category?.eventColor)
            eventCategory.setTextColor(event.category?.eventColor)
            
            eventLabel.setAccessibilityIdentifier("detailsScreenEventLabel")
            eventCategory.setAccessibilityIdentifier("detailsScreenEventCategory")
            eventImage.setAccessibilityIdentifier("detailsScreenEventImage")
            
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        longPressGesture.minimumPressDuration = 2
        
        if let event = context as? Event {
            self.event = event
        }
    }
    
    private func goToWristLocationScreen() {
        guard !pushWristLocationScreen else {
            return
        }
        self.pushController(withName: "WristLocationInterfaceController", context: nil)
        pushWristLocationScreen = true
    }
}
