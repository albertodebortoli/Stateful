//
//  TransitionTests.swift
//  Stateful
//
//  Created by Alberto De Bortoli on 16/12/2018.
//

import XCTest
@testable import Stateful

class TransitionTests: XCTestCase {
    
    func test_Creation() {
        let event = "event"
        let from = "from"
        let to = "to"
        let transition = Transition(with: event, from: from, to: to)
        XCTAssertEqual(transition.event, event)
        XCTAssertEqual(transition.source, from)
        XCTAssertEqual(transition.destination, to)
    }
    
    func test_Callback() {
        let expectation1 = XCTestExpectation(description: #function)
        let expectation2 = XCTestExpectation(description: #function)
        let transition = Transition(with: "event", from: "from", to: "to", preBlock: {
            expectation1.fulfill()
        }, postBlock: {
            expectation2.fulfill()
        })
        transition.executePreBlock()
        wait(for: [expectation1], timeout: 2)
        transition.executePostBlock()
        wait(for: [expectation2], timeout: 2)
    }
}
