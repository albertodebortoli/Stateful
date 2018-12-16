//
//  Event.swift
//  Stateful
//
//  Created by Alberto De Bortoli on 16/12/2018.
//

import Foundation

public struct Event {
    
    public let name: String
    let callback: TransitionBlock?
    
    public init(_ name: String,
                callback: TransitionBlock? = nil) {
        self.name = name
        self.callback = callback
    }
    
    func executeCallback() {
        callback?(.success)
    }
    
    func executeDiscardedCallback() {
        callback?(.failure)
    }
}
