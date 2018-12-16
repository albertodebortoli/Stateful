//
//  AppDelegate.swift
//  Stateful
//
//  Created by Alberto De Bortoli on 12/16/2018.
//  Copyright (c) 2018 albertodebortoli.website@gmail.com. All rights reserved.
//

import UIKit
import Stateful

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        runSampleStateMachine()
        
        return true
    }
    
    func runSampleStateMachine() {
        
        let dispatchQueue = DispatchQueue(label: "com.albertodebortoli.someSerialCallbackQueue")
        let stateMachine = StateMachine(initialState: "idle", callbackQueue: dispatchQueue)
        stateMachine.enableLogging = true
        
        let t1 = Transition(with: Event.start.rawValue,
                            from: State.idle.rawValue,
                            to: State.started.rawValue,
                            preBlock: {
                                print("Gonna move from \(State.idle) to \(State.started)!")
                            }, postBlock: {
                                print("Just moved from \(State.idle) to \(State.started)!")
        })
        
        let t2 = Transition(with: Event.stop.rawValue,
                            from: State.started.rawValue,
                            to: State.idle.rawValue,
                            preBlock: {
                                print("Gonna move from \(State.started) to Idle!")
                            }, postBlock: {
                                print("Just moved from \(State.started) to \(State.idle)!")
        })
        
        let t3 = Transition(with: Event.execute.rawValue,
                            from: State.started.rawValue,
                            to: State.running.rawValue,
                            preBlock: {
                                print("Gonna move from \(State.started) to \(State.running)!")
                            }, postBlock: {
                                print("Just moved from \(State.started) to \(State.running)!")
        })
        
        let t4 = Transition(with: Event.stop.rawValue,
                            from: State.running.rawValue,
                            to: State.idle.rawValue,
                            preBlock: {
                                print("Gonna move from \(State.running) to \(State.idle)!")
                            }, postBlock: {
                                print("Just moved from \(State.running) to \(State.idle)!")
        })
        
        let t5 = Transition(with: Event.complete.rawValue,
                            from: State.running.rawValue,
                            to: State.completed.rawValue,
                            preBlock: {
                                print("Gonna move from \(State.running) to \(State.completed)!")
                            }, postBlock: {
                                print("Just moved from \(State.running) to \(State.completed)!")
        })
        
        stateMachine.add(transition: t1)
        stateMachine.add(transition: t2)
        stateMachine.add(transition: t3)
        stateMachine.add(transition: t4)
        stateMachine.add(transition: t5)
        
        stateMachine.process(event: "start")
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

