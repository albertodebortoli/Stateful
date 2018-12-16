//
//  Transition.swift
//  Stateful
//
//  Created by Alberto De Bortoli on 16/12/2018.
//

import Foundation

public struct Transition {
    
    public let event: String
    public let from: String
    public let to: String
    let preBlock: (() -> Void)?
    let postBlock: (() -> Void)?
    
    public init(with event: String,
                from: String,
                to: String,
                preBlock: (() -> Void)? = nil,
                postBlock: (() -> Void)? = nil) {
        self.event = event
        self.from = from
        self.to = to
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
