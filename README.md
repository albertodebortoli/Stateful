# Stateful 🦜

[![Build Status](https://travis-ci.org/albertodebortoli/Stateful.svg?branch=master)](https://travis-ci.org/albertodebortoli/Stateful)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-iOS%2013%2B%20%7C%20macOS%2010.15%2B-lightgrey.svg)](https://developer.apple.com/)

The easiest state machine in Swift.

Stateful is a minimalistic, thread-safe, non-boilerplate and super easy to use state machine in Swift.

## Example

- define the events and statuses you need. E.g.:

```swift
enum EventType {
    case start
    case pause
}

enum StateType {
    case idle
    case started
}
```

- create a state machine with the initial state (you might want to retain it in a property)

```swift
let stateMachine = StateMachine<StateType, EventType>(initialState: .idle)
```

`StateMachine` will use the main queue to execute the transition pre and post blocks but you can optionally provide a custom one.

```swift
let dispatchQueue = DispatchQueue(label: "com.albertodebortoli.someSerialCallbackQueue")
let stateMachine = StateMachine<StateType, EventType>(initialState: StateType.idle, callbackQueue: dispatchQueue)
```

- create transitions and add them to the state machine (the state machine will automatically recognize the new statuses)

```swift
let t1 = Transition<StateType, EventType>(with: .start,
                    from: .idle,
                    to: .started)
                    
let t2 = Transition<StateType, EventType>(with: .pause,
                    from: .started,
                    to: .idle,
                    preBlock: {
                        print("Going to move from \(StateType.started) to \(StateType.idle)!")
                    }, postBlock: {
                        print("Just moved from \(StateType.started) to \(StateType.idle)!")
    })

stateMachine.add(transition: t1)
stateMachine.add(transition: t2)
```

- process events like so

```swift
stateMachine.process(event: .start)
stateMachine.process(event: .pause, callback: { result in
    switch result {
    case .success:
        print("Event 'pause' was processed")
    case .failure:
        print("Event 'pause' cannot currently be processed.")
    }
})
```

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

### Swift Package Manager

Add Stateful to your project using Xcode:

1. File → Add Package Dependencies...
2. Enter the repository URL: `https://github.com/albertodebortoli/Stateful.git`
3. Select the version you want to use

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/albertodebortoli/Stateful.git", from: "1.0.0")
]
```

## Author

Alberto De Bortoli, albertodebortoli.website@gmail.com

## License

Stateful is available under the MIT license. See the LICENSE file for more info.
