import XCTest

import StatefulTests

var tests = [XCTestCaseEntry]()
tests += StatefulTests.allTests()
XCTMain(tests)
