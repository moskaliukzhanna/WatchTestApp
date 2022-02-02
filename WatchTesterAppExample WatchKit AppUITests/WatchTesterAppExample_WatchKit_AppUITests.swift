//
//  WatchTesterAppExample_WatchKit_AppUITests.swift
//  WatchTesterAppExample WatchKit AppUITests
//
//  Created by Zhanna Moskaliuk on 02.11.2021.
//

import XCTest
import WatchKit
import WatchTester

class WatchTesterAppExample_WatchKit_AppUITests: XCTestCase {
    
    let timeout: TimeInterval = 60 * 60 * 24
    
    private var expectation: XCTestExpectation?
    
    var watchTester: WatchTester!
    
    private let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = true
        expectation = XCTestExpectation(description: "All tests are finished.")
        
        // init watch tester
        // then start websocket connection
        watchTester = WatchTester(app: app)
        watchTester.connect()
        switchWristLocation()
        
        watchTester.fulfillComplition = { [weak self] in
            guard let self = self else { return }
            self.switchWristLocation()
            self.expectation?.fulfill()
        }
    }
    
    func testLaunch() {
        print("App should launch")
        wait(for: [expectation!], timeout: timeout)
    }
    
    func switchWristLocation() {
        let location = WKInterfaceDevice.current().wristLocation
        print("LOCATION: \(location.rawValue)")
    }
}
