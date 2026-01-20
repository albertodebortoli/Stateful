//  Transition.swift

import Foundation

public typealias ExecutionBlock = @Sendable () async throws -> Void

public struct Transition<State: Sendable, Event: Sendable>: Sendable {
    
    public let event: Event
    public let source: State
    public let destination: State
    let preBlock: ExecutionBlock?
    let postBlock: ExecutionBlock?
    
    public init(with event: Event,
                from: State,
                to: State,
                preBlock: ExecutionBlock? = nil,
                postBlock: ExecutionBlock? = nil) {
        self.event = event
        self.source = from
        self.destination = to
        self.preBlock = preBlock
        self.postBlock = postBlock
    }
    
    func executePreBlock() async throws {
        try await preBlock?()
    }
    
    func executePostBlock() async throws {
        try await postBlock?()
    }
}
