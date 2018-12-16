//
//  EventTests.swift
//  Stateful
//
//  Created by Alberto De Bortoli on 16/12/2018.
//

import XCTest
@testable import Stateful

class EventTests: XCTestCase {
    
    func test_Creation() {
        let name = "event"
        let event = Event(name)
        XCTAssertEqual(event.name, name)
    }
    
    func test_Callback() {
        let expectation = XCTestExpectation(description: #function)
        let name = "event"
        let callback = {
            expectation.fulfill()
        }
        let event = Event(name, callback: callback)
        event.executeCallback()
        wait(for: [expectation], timeout: 2)
    }
    
    func test_DiscardedCallback() {
        let expectation = XCTestExpectation(description: #function)
        let name = "event"
        let discarded = {
            expectation.fulfill()
        }
        let event = Event(name, discarded: discarded)
        event.executeDiscardedCallback()
        wait(for: [expectation], timeout: 2)
    }
}
