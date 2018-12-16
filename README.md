# Stateful 🦜

[![Build Status](https://app.bitrise.io/app/5b1bed7dfe1521fd/status.svg?token=O8hUIAOKc9Ij6yey8qkQvg&branch=master)](https://app.bitrise.io/app/5b1bed7dfe1521fd)
[![Version](https://img.shields.io/cocoapods/v/Stateful.svg?style=flat)](https://cocoapods.org/pods/Stateful)
[![License](https://img.shields.io/cocoapods/l/Stateful.svg?style=flat)](https://cocoapods.org/pods/Stateful)
[![Platform](https://img.shields.io/cocoapods/p/Stateful.svg?style=flat)](https://cocoapods.org/pods/Stateful)

The easiest state machine in Swift.

Stateful is a minimalistic, thread-safe, non-boilerplate and super easy to use state machine in Swift.

## Example

- create a state machine with the initial state and assign it to a property

```swift
let stateMachine = StateMachine(initialState: "idle")
```

`StateMachine` will use the main queue to execute the transition pre and post blocks but you can optionally provide a custom one.

```swift
let dispatchQueue = DispatchQueue(label: "com.albertodebortoli.someSerialCallbackQueue")
let stateMachine = StateMachine(initialState: "idle", callbackQueue: dispatchQueue)
```

- define the events and status you need. `Transition` expects strings by design. E.g.:

```swift
enum Event: String {
    case start
    case pause
}

enum State: String {
    case idle
    case started
}
```

- create transitions and add them to the state machine (the state machine will automatically recognize the new states)

```swift
let t1 = Transition(with: Event.start.rawValue, fromState: State.idle.rawValue, toState: State.started.rawValue)

let t2 = Transition(with: Event.pause.rawValue,
                    from: State.started.rawValue,
                    to: State.idle.rawValue,
                    preBlock: {
                        print("Going to move from \(State.started) to \(State.idle)!")
                    }, postBlock: {
                        print("Just moved from \(State.started) to \(State.idle)!")
    })

stateMachine.add(transition: t1)
stateMachine.add(transition: t2)
```

- process events like so

```swift
stateMachine.process(event: Event.start.rawValue)
stateMachine.process(event: Event.pause.rawValue)
```

or using the `Event` struct:



### Logging

You can optionally enable logging to print extra state change information on the console 

```swift
stateMachine.enableLogging = true
```

Example:

```
[Stateful 🦜]: Processing event 'start' from 'idle'
[Stateful 🦜]: Processed pre condition for event 'start' from 'idle' to 'started'
[Stateful 🦜]: Processed state change from 'idle' to 'started'
[Stateful 🦜]: Processed post condition for event 'start' from 'idle' to 'started'
[Stateful 🦜]: Processing event 'stop' from 'started'
[Stateful 🦜]: Processed pre condition for event 'stop' from 'started' to 'idle'
[Stateful 🦜]: Processed state change from 'started' to 'idle'
[Stateful 🦜]: Processed post condition for event 'stop' from 'started' to 'idle'
```

## Installation

Stateful is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Stateful'
```

## Author

Alberto De Bortoli, albertodebortoli.website@gmail.com

## License

Stateful is available under the MIT license. See the LICENSE file for more info.
