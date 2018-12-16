//
//  Transition.swift
//  Stateful
//
//  Created by Alberto De Bortoli on 16/12/2018.
//

import Foundation

public struct Transition {
    
    let event: String
    let from: String
    let to: String
    private let preBlock: (() -> Void)?
    private let postBlock: (() -> Void)?
    
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
    
    func processPreBlock() {
        preBlock?()
    }
    
    func processPostBlock() {
        postBlock?()
    }
}
