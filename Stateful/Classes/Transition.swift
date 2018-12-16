//
//  Transition.swift
//  Stateful
//
//  Created by Alberto De Bortoli on 16/12/2018.
//

import Foundation

public enum TrasitionResult {
    case success
    case failure
}

public typealias ExecutionBlock = (() -> Void)
public typealias TransitionBlock = ((TrasitionResult) -> Void)

public struct Transition {
    
    public let event: String
    public let source: String
    public let destination: String
    let preBlock: ExecutionBlock?
    let postBlock: ExecutionBlock?
    
    public init(with event: String,
                from: String,
                to: String,
                preBlock: ExecutionBlock? = nil,
                postBlock: ExecutionBlock? = nil) {
        self.event = event
        self.source = from
        self.destination = to
        self.preBlock = preBlock
        self.postBlock = postBlock
    }
    
    func executePreBlock() {
        preBlock?()
    }
    
    func executePostBlock() {
        postBlock?()
    }
}
