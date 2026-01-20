//  StateMachine.swift

import Foundation

public actor StateMachine<State: Hashable & Sendable, Event: Hashable & Sendable> {
    
    enum StateMachineError: Error {
        case noTransitionForEvent(Event)
    }
    
    nonisolated(unsafe) public var enableLogging: Bool = false
    public private(set) var currentState: State
    
    private var transitionsByEvent: [Event: [Transition<State, Event>]] = [:]
    
    public init(initialState: State) {
        self.currentState = initialState
    }
    
    public func add(transition: Transition<State, Event>) {
        if let transitions = transitionsByEvent[transition.event] {
            if transitions.contains(where: { $0.source == transition.source }) {
                assertionFailure("Transition with event '\(transition.event)' and source '\(transition.source)' already existing.")
            }
            transitionsByEvent[transition.event]?.append(transition)
        } else {
            transitionsByEvent[transition.event] = [transition]
        }
    }
    
    public func process(event: Event) throws {
        let transitions = transitionsByEvent[event]
        let performableTransitions = transitions?.filter { $0.source == currentState } ?? []
        
        if performableTransitions.isEmpty {
            throw StateMachineError.noTransitionForEvent(event)
        }
        
        assert(performableTransitions.count == 1, "Found multiple transitions with event '\(event)' and source '\(currentState)'.")
        
        let transition = performableTransitions.first!
        
        log(message: "Processing event '\(event)' from '\(currentState)'")
        transition.executePreBlock()
        
        log(message: "Processed pre condition for event '\(event)' from '\(transition.source)' to '\(transition.destination)'")
        
        let previousState = currentState
        currentState = transition.destination
        
        log(message: "Processed state change from '\(previousState)' to '\(transition.destination)'")
        transition.executePostBlock()
        
        log(message: "Processed post condition for event '\(event)' from '\(transition.source)' to '\(transition.destination)'")
    }
    
    private func log(message: String) {
        if enableLogging {
            print("[Stateful 🦜] \(message)")
        }
    }
}
