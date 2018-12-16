//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Stateful

class StateMachineExamples {

    enum EventType: String {
        case start
        case stop
        case execute
        case complete
    }
    
    enum StateType: String {
        case idle
        case started
        case running
        case completed
    }
    
    func runSampleStateMachine() {
        
        let dispatchQueue = DispatchQueue(label: "com.albertodebortoli.someSerialCallbackQueue")
        let stateMachine = StateMachine(initialState: "idle", callbackQueue: dispatchQueue)
        stateMachine.enableLogging = true
        
        let t1 = Transition(with: EventType.start.rawValue,
                            from: StateType.idle.rawValue,
                            to: StateType.started.rawValue,
                            preBlock: {
                                print("Going to move from \(StateType.idle) to \(StateType.started)!")
        }, postBlock: {
            print("Just moved from \(StateType.idle) to \(StateType.started)!")
        })
        
        let t2 = Transition(with: EventType.stop.rawValue,
                            from: StateType.started.rawValue,
                            to: StateType.idle.rawValue,
                            preBlock: {
                                print("Going to move from \(StateType.started) to Idle!")
        }, postBlock: {
            print("Just moved from \(StateType.started) to \(StateType.idle)!")
        })
        
        let t3 = Transition(with: EventType.execute.rawValue,
                            from: StateType.started.rawValue,
                            to: StateType.running.rawValue,
                            preBlock: {
                                print("Going to move from \(StateType.started) to \(StateType.running)!")
        }, postBlock: {
            print("Just moved from \(StateType.started) to \(StateType.running)!")
        })
        
        let t4 = Transition(with: EventType.stop.rawValue,
                            from: StateType.running.rawValue,
                            to: StateType.idle.rawValue,
                            preBlock: {
                                print("Going to move from \(StateType.running) to \(StateType.idle)!")
        }, postBlock: {
            print("Just moved from \(StateType.running) to \(StateType.idle)!")
        })
        
        let t5 = Transition(with: EventType.complete.rawValue,
                            from: StateType.running.rawValue,
                            to: StateType.completed.rawValue,
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
        
        stateMachine.process(event: "start", callback: callback)
        stateMachine.process(event: "start", callback: callback)
        stateMachine.process(event: "stop")
        stateMachine.process(event: "start")
        stateMachine.process(event: "stop")
        stateMachine.process(event: "start")
        stateMachine.process(event: "execute")
        stateMachine.process(event: "start")
        stateMachine.process(event: "stop")
        stateMachine.process(event: "start")
        stateMachine.process(event: "execute")
        stateMachine.process(event: "complete")
        stateMachine.process(event: "start")
        stateMachine.process(event: "stop")
    }
}

StateMachineExamples().runSampleStateMachine()
