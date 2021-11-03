//
//  WatchTesterAppExample_WatchKit_AppUITests.swift
//  WatchTesterAppExample WatchKit AppUITests
//
//  Created by Zhanna Moskaliuk on 02.11.2021.
//

import XCTest
import WatchTester

class WatchTesterAppExample_WatchKit_AppUITests: XCTestCase {
    
    var watchTester: WatchTester!
    
    let timeout: TimeInterval = 60 * 60 * 24
    
    private var expectation: XCTestExpectation?
    
    private let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        expectation = XCTestExpectation(description: "All tests are finished.")
        
        continueAfterFailure = false
        
        // init watch tester
        // then start websocket connection
        watchTester = WatchTester(app: app)
        watchTester.connect()
        
        watchTester.shutdownCompletion = { [weak self] in
            guard let self = self else { return }
            self.expectation?.fulfill()
        }
        
        // wait untill connection is stablished
//        app.launch()
        wait(for: [expectation!], timeout: timeout)
    }
    
    func testLaunch() {
        print("App should launch")
    }
}
