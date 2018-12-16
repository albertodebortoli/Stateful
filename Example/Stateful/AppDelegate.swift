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
        
        let t1 = Transition(with: "start", fromState: "idle", toState: "started", preBlock: {
            print("Gonna move from Idle to Started!")
        }) {
            print("Just moved from Idle to Started!")
        }

        let t2 = Transition(with: "stop", fromState: "started", toState: "idle", preBlock: {
            print("Gonna move from Started to Idle!")
        }) {
            print("Just moved from Started to Idle!")
        }
        
        let t3 = Transition(with: "execute", fromState: "started", toState: "running", preBlock: {
            print("Gonna move from Started to Running!")
        }) {
            print("Just moved from Started to Running!")
        }
        
        let t4 = Transition(with: "stop", fromState: "running", toState: "idle", preBlock: {
            print("Gonna move from Running to Idle!")
        }) {
            print("Just moved from Running to Idle!")
        }
        
        let t5 = Transition(with: "complete", fromState: "running", toState: "completed", preBlock: {
            print("Gonna move from Running to Completed!")
        }) {
            print("Just moved from Running to Completed!")
        }
        
        stateMachine.addTransition(transition: t1)
        stateMachine.addTransition(transition: t2)
        stateMachine.addTransition(transition: t3)
        stateMachine.addTransition(transition: t4)
        stateMachine.addTransition(transition: t5)
        
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

