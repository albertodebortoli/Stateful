//
//  Event.swift
//  Stateful
//
//  Created by Alberto De Bortoli on 16/12/2018.
//

import Foundation

public struct Event {
    
    public let name: String
    let callback: (() -> Void)?
    let discardedCallback: (() -> Void)?
    
    public init(_ name: String,
                callback: (() -> Void)? = nil,
                discarded: (() -> Void)? = nil) {
        self.name = name
        self.callback = callback
        self.discardedCallback = discarded
    }
    
    func executeCallback() {
        callback?()
    }
    
    func executeDiscardedCallback() {
        discardedCallback?()
    }
}
