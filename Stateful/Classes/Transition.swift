//
//  Transition.swift
//  Stateful
//
//  Created by Alberto De Bortoli on 16/12/2018.
//

import Foundation

public struct Transition {
    
    let event: String
    let fromState: String
    let toState: String
    private let preBlock: (() -> Void)?
    private let postBlock: (() -> Void)?
    
    public init(with event: String,
                fromState: String,
                toState: String,
                preBlock: (() -> Void)? = nil,
                postBlock: (() -> Void)? = nil) {
        self.event = event
        self.fromState = fromState
        self.toState = toState
        self.preBlock = preBlock
        self.postBlock = postBlock
    }
    
    func processPreBlock() {
        preBlock?()
    }
    
    func processPostBlock() {
        postBlock?()
    }
}
