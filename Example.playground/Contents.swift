import UIKit
import PlaygroundSupport
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
    
    func runSampleStateMachine() {
        
        let dispatchQueue = DispatchQueue(label: "com.albertodebortoli.someSerialCallbackQueue")
        let stateMachine = StateMachineDefault(initialState: .idle,
                                               callbackQueue: dispatchQueue)
        stateMachine.enableLogging = true
        
        let t1 = TransitionDefault(with: EventType.start,
                                   from: StateType.idle,
                                   to: StateType.started,
                                   preBlock: {
                                    print("Going to move from \(StateType.idle) to \(StateType.started)!")
        }, postBlock: {
            print("Just moved from \(StateType.idle) to \(StateType.started)!")
        })
        
        let t2 = TransitionDefault(with: .stop,
                                   from: .started,
                                   to: .idle,
                                   preBlock: {
                                    print("Going to move from \(StateType.started) to Idle!")
        }, postBlock: {
            print("Just moved from \(StateType.started) to \(StateType.idle)!")
        })
        
        let t3 = TransitionDefault(with: .execute,
                                   from: .started,
                                   to: .running,
                                   preBlock: {
                                    print("Going to move from \(StateType.started) to \(StateType.running)!")
        }, postBlock: {
            print("Just moved from \(StateType.started) to \(StateType.running)!")
        })
        
        let t4 = TransitionDefault(with: .stop,
                                   from: .running,
                                   to: .idle,
                                   preBlock: {
                                    print("Going to move from \(StateType.running) to \(StateType.idle)!")
        }, postBlock: {
            print("Just moved from \(StateType.running) to \(StateType.idle)!")
        })
        
        let t5 = TransitionDefault(with: .complete,
                                   from: .running,
                                   to: .completed,
                                   preBlock: {
                                    print("Going to move from \(StateType.running) to \(StateType.completed)!")
        }, postBlock: {
            print("Just moved from \(StateType.running) to \(StateType.completed)!")
        })
        
        stateMachine.add(transition: t1)
        stateMachine.add(transition: t2)
        stateMachine.add(transition: t3)
        stateMachine.add(transition: t4)
        stateMachine.add(transition: t5)
        
        let callback: TransitionBlock = { result in
            switch result {
            case .success:
                print("Event 'start' was processed")
            case .failure:
                print("Event 'start' cannot currently be processed.")
            }
        }
        
        stateMachine.process(event: .start, callback: callback)
        stateMachine.process(event: .start, callback: callback)
        stateMachine.process(event: .stop)
        stateMachine.process(event: .start)
        stateMachine.process(event: .stop)
        stateMachine.process(event: .start)
        stateMachine.process(event: .execute)
        stateMachine.process(event: .start)
        stateMachine.process(event: .stop)
        stateMachine.process(event: .start)
        stateMachine.process(event: .execute)
        stateMachine.process(event: .complete)
        stateMachine.process(event: .start)
        stateMachine.process(event: .stop)
    }
}

StateMachineExamples().runSampleStateMachine()
