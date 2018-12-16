//
//  Constants.swift
//  Stateful_Example
//
//  Created by Alberto De Bortoli on 16/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

enum Event: String {
    case start
    case stop
    case execute
    case complete
}

enum State: String {
    case idle
    case started
    case running
    case completed
}
