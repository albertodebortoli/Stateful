//
//  StateMachineTests.swift
//  Stateful
//
//  Created by Alberto De Bortoli on 16/12/2018.
//

import XCTest
@testable import Stateful

class StateMachineTests: XCTestCase {
    
    typealias TransitionDefault = Transition<StateType, EventType>
    typealias StateMachineDefault = StateMachine<StateType, EventType>
    
    enum EventType: Sendable {
        case e1
        case e2
    }
    
    enum StateType: Sendable {
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
    
    func test_Creation() async {
        let state = await stateMachine.currentState
        XCTAssertEqual(state, .idle)
    }
    
    func test_SingleTransition() async {
        var result = await stateMachine.process(event: .e1)
        XCTAssertEqual(result, .failure)
        var state = await stateMachine.currentState
        XCTAssertEqual(state, .idle)
        
        let transition = TransitionDefault(with: .e1, from: .idle, to: .started)
        await stateMachine.add(transition: transition)
        result = await stateMachine.process(event: .e1)
        XCTAssertEqual(result, .success)
        state = await stateMachine.currentState
        XCTAssertEqual(state, .started)
    }
    
    func test_MultipleTransistions() async {
        var result = await stateMachine.process(event: .e1)
        XCTAssertEqual(result, .failure)
        var state = await stateMachine.currentState
        XCTAssertEqual(state, .idle)
        
        let transition1 = TransitionDefault(with: .e1, from: .idle, to: .started)
        await stateMachine.add(transition: transition1)
        let transition2 = TransitionDefault(with: .e2, from: .started, to: .idle)
        await stateMachine.add(transition: transition2)
        let transition3 = TransitionDefault(with: .e1, from: .started, to: .idle)
        await stateMachine.add(transition: transition3)
        
        result = await stateMachine.process(event: .e1)
        XCTAssertEqual(result, .success)
        state = await stateMachine.currentState
        XCTAssertEqual(state, .started)
        
        result = await stateMachine.process(event: .e2)
        XCTAssertEqual(result, .success)
        state = await stateMachine.currentState
        XCTAssertEqual(state, .idle)
        
        result = await stateMachine.process(event: .e1)
        XCTAssertEqual(result, .success)
        state = await stateMachine.currentState
        XCTAssertEqual(state, .started)
        
        result = await stateMachine.process(event: .e1)
        XCTAssertEqual(result, .success)
        state = await stateMachine.currentState
        XCTAssertEqual(state, .idle)
    }
}
