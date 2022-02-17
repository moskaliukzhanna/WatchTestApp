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
    
    private let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // init watch tester
        // then start websocket connection
        watchTester = WatchTester(app: app)
        watchTester.connect()
    }
    
    func testLaunch() {
        print("App should launch")
    }
}
