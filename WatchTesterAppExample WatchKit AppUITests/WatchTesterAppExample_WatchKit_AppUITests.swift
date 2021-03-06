//
//  WatchTesterAppExample_WatchKit_AppUITests.swift
//  WatchTesterAppExample WatchKit AppUITests
//
//  Created by Zhanna Moskaliuk on 02.11.2021.
//

import XCTest
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
        
        watchTester.fulfillComplition = { [weak self] in
            guard let self = self else { return }
            self.expectation?.fulfill()
        }
        wait(for: [expectation!], timeout: timeout)
    }
    
    func testLaunch() {
        print("App should launch")
    }
}
