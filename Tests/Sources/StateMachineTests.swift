//  StateMachineTests.swift

import Testing
@testable import Stateful

struct StateMachineTests {
    
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
    
    var stateMachine: StateMachine<StateType, EventType>
    
    init() {
        stateMachine = StateMachineDefault(initialState: .idle)
        stateMachine.enableLogging = true
    }
    
    @Test func creation() async {
        let state = await stateMachine.currentState
        #expect(state == .idle)
    }
    
    @Test func singleTransition() async {
        var result = await stateMachine.process(event: .e1)
        #expect(result == .failure)
        var state = await stateMachine.currentState
        #expect(state == .idle)
        
        let transition = TransitionDefault(with: .e1, from: .idle, to: .started)
        await stateMachine.add(transition: transition)
        result = await stateMachine.process(event: .e1)
        #expect(result == .success)
        state = await stateMachine.currentState
        #expect(state == .started)
    }
    
    @Test func multipleTransitions() async {
        var result = await stateMachine.process(event: .e1)
        #expect(result == .failure)
        var state = await stateMachine.currentState
        #expect(state == .idle)
        
        let transition1 = TransitionDefault(with: .e1, from: .idle, to: .started)
        await stateMachine.add(transition: transition1)
        let transition2 = TransitionDefault(with: .e2, from: .started, to: .idle)
        await stateMachine.add(transition: transition2)
        let transition3 = TransitionDefault(with: .e1, from: .started, to: .idle)
        await stateMachine.add(transition: transition3)
        
        result = await stateMachine.process(event: .e1)
        #expect(result == .success)
        state = await stateMachine.currentState
        #expect(state == .started)
        
        result = await stateMachine.process(event: .e2)
        #expect(result == .success)
        state = await stateMachine.currentState
        #expect(state == .idle)
        
        result = await stateMachine.process(event: .e1)
        #expect(result == .success)
        state = await stateMachine.currentState
        #expect(state == .started)
        
        result = await stateMachine.process(event: .e1)
        #expect(result == .success)
        state = await stateMachine.currentState
        #expect(state == .idle)
    }
}
