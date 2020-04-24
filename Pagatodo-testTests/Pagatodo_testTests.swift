//
//  Pagatodo_testTests.swift
//  Pagatodo-testTests
//
//  Created by Jc on 23/04/20.
//  Copyright © 2020 Jc. All rights reserved.
//

import XCTest
@testable import Pagatodo_test

class Pagatodo_testTests: XCTestCase {
    
    var user: User!
    let httpManager = HttpManager.shareInstance

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            testGetUsersFromApi()
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetUsersFromApi() {
        httpManager.getUsers(from: "users") { users in
            XCTAssertTrue(users.count > 0, "REQUEST IS READY")
        }
    }

}
