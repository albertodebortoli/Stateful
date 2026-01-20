//  TransitionTests.swift

import Testing
@testable import Stateful

struct TransitionTests {
    
    @Test func creation() {
        let event = "event"
        let from = "from"
        let to = "to"
        let transition = Transition(with: event, from: from, to: to)
        #expect(transition.event == event)
        #expect(transition.source == from)
        #expect(transition.destination == to)
    }
    
    @Test func callback() async throws {
        try await confirmation("preBlock called") { preConfirmation in
            try await confirmation("postBlock called") { postConfirmation in
                let transition = Transition(with: "event", from: "from", to: "to", preBlock: {
                    preConfirmation()
                }, postBlock: {
                    postConfirmation()
                })
                try await transition.executePreBlock()
                try await transition.executePostBlock()
            }
        }
    }
}
