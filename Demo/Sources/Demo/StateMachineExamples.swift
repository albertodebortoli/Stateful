//  StateMachineExamples.swift

import Stateful

class StateMachineExamples {
    
    typealias TransitionDefault = Transition<StateType, EventType>
    typealias StateMachineDefault = StateMachine<StateType, EventType>
    
    enum EventType {
        case start
        case stop
        case execute
        case complete
    }
    
    enum StateType {
        case idle
        case started
        case running
        case completed
    }
    
    func runSampleStateMachine() async throws {
        let stateMachine = StateMachineDefault(initialState: .idle)
        stateMachine.enableLogging = true
        
        let t1 = TransitionDefault(
            with: .start,
            from: .idle,
            to: .started,
            preBlock: {
                print(
                    "Going to move from \(StateType.idle) to \(StateType.started)!"
                )
            },
            postBlock: {
                print(
                    "Just moved from \(StateType.idle) to \(StateType.started)!"
                )
        })
        
        let t2 = TransitionDefault(
            with: .stop,
            from: .started,
            to: .idle,
            preBlock: {
                print("Going to move from \(StateType.started) to Idle!")
            }, postBlock: {
                print("Just moved from \(StateType.started) to \(StateType.idle)!")
            })
        
        let t3 = TransitionDefault(
            with: .execute,
            from: .started,
            to: .running,
            preBlock: {
                print("Going to move from \(StateType.started) to \(StateType.running)!")
            }, postBlock: {
                print("Just moved from \(StateType.started) to \(StateType.running)!")
        })
        
        let t4 = TransitionDefault(
            with: .stop,
            from: .running,
            to: .idle,
            preBlock: {
                print("Going to move from \(StateType.running) to \(StateType.idle)!")
            }, postBlock: {
                print("Just moved from \(StateType.running) to \(StateType.idle)!")
        })
        
        let t5 = TransitionDefault(
            with: .complete,
            from: .running,
            to: .completed,
            preBlock: {
                print("Going to move from \(StateType.running) to \(StateType.completed)!")
            }, postBlock: {
                print("Just moved from \(StateType.running) to \(StateType.completed)!")
            })
        
        await stateMachine.add(transition: t1)
        await stateMachine.add(transition: t2)
        await stateMachine.add(transition: t3)
        await stateMachine.add(transition: t4)
        await stateMachine.add(transition: t5)
        
        do {
            try await stateMachine.process(event: .start)
            print("Event 'start' was processed")
        } catch {
            print("Event 'start' cannot currently be processed.")
        }
        
        do {
            try await stateMachine.process(event: .start)
            print("Event 'start' was processed")
        } catch {
            print("Event 'start' cannot currently be processed.")
        }
        
        try await stateMachine.process(event: .stop)
        try await stateMachine.process(event: .start)
        try await stateMachine.process(event: .stop)
        try await stateMachine.process(event: .start)
        try await stateMachine.process(event: .execute)
    }
}
