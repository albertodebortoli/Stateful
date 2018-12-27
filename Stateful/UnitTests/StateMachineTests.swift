//
//  StateMachine.swift
//  Stateful
//
//  Created by Alberto De Bortoli on 16/12/2018.
//

import XCTest
@testable import Stateful

class aTests: XCTestCase {
    
    typealias TransitionDefault = Transition<StateType, EventType>
    typealias StateMachineDefault = StateMachine<StateType, EventType>
    
    enum EventType {
        case e1
        case e2
    }
    
    enum StateType {
        case idle
        case started
        case running
        case completed
    }
    
    var stateMachine: StateMachine<StateType, EventType>!
    
    override func setUp() {
        super.setUp()
        stateMachine = StateMachineDefault(initialState: .idle)
        stateMachine.enableLogging = true
    }
    
    override func tearDown() {
        stateMachine = nil
        super.tearDown()
    }
    
    func test_Creation() {
        XCTAssertEqual(stateMachine.currentState, .idle)
    }
    
    func test_SingleTransition() {
        stateMachine.process(event: .e1)
        XCTAssertEqual(stateMachine.currentState, .idle)
        
        let transition = TransitionDefault(with: .e1, from: .idle, to: .started)
        stateMachine.add(transition: transition)
        stateMachine.process(event: .e1)
        XCTAssertEqual(stateMachine.currentState, .started)
    }
    
    func test_MultipleTransistions() {
        stateMachine.process(event: .e1)
        XCTAssertEqual(stateMachine.currentState, .idle)
        
        let transition1 = TransitionDefault(with: .e1, from: .idle, to: .started)
        stateMachine.add(transition: transition1)
        let transition2 = TransitionDefault(with: .e2, from: .started, to: .idle)
        stateMachine.add(transition: transition2)
        let transition3 = TransitionDefault(with: .e1, from: .started, to: .idle)
        stateMachine.add(transition: transition3)
        
        stateMachine.process(event: .e1)
        XCTAssertEqual(stateMachine.currentState, .started)
        stateMachine.process(event: .e2)
        XCTAssertEqual(stateMachine.currentState, .idle)
        stateMachine.process(event: .e1)
        XCTAssertEqual(stateMachine.currentState, .started)
        stateMachine.process(event: .e1)
        XCTAssertEqual(stateMachine.currentState, .idle)
    }
}
