//
//  StateMachine.swift
//  Stateful
//
//  Created by Alberto De Bortoli on 16/12/2018.
//

import XCTest
@testable import Stateful

class aTests: XCTestCase {
    
    var stateMachine: StateMachine!
    
    override func setUp() {
        super.setUp()
        stateMachine = StateMachine(initialState: "idle")
        stateMachine.enableLogging = true
    }
    
    override func tearDown() {
        stateMachine = nil
        super.tearDown()
    }
    
    func test_Creation() {
        XCTAssertEqual(stateMachine.currentState, "idle")
    }
    
    func test_ProcessingSingleTransition() {
        stateMachine.process(event: "e1")
        XCTAssertEqual(stateMachine.currentState, "idle")
        
        let transition = Transition(with: "e1", from: "idle", to: "started")
        stateMachine.add(transition: transition)
        stateMachine.process(event: "e1")
        XCTAssertEqual(stateMachine.currentState, "started")
    }
    
    func test_MultipleTransistionsWithSameEvent() {
        stateMachine.process(event: "e1")
        XCTAssertEqual(stateMachine.currentState, "idle")
        
        let transition1 = Transition(with: "e1", from: "idle", to: "started")
        stateMachine.add(transition: transition1)
        let transition2 = Transition(with: "e2", from: "started", to: "idle")
        stateMachine.add(transition: transition2)
        let transition3 = Transition(with: "e1", from: "started", to: "idle")
        stateMachine.add(transition: transition3)
        
        stateMachine.process(event: "e1")
        XCTAssertEqual(stateMachine.currentState, "started")
        stateMachine.process(event: "e2")
        XCTAssertEqual(stateMachine.currentState, "idle")
        stateMachine.process(event: "e1")
        XCTAssertEqual(stateMachine.currentState, "started")
        stateMachine.process(event: "e1")
        XCTAssertEqual(stateMachine.currentState, "idle")
    }
}
