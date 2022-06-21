//
//  AsyncSequenceTests.swift
//  
//
//  Created by Ameter, Chris on 6/21/22.
//

import XCTest
@testable import ConcurrencyDemo

final class AsyncSequenceTests: XCTestCase {
    let sequence = Doubles()

    func testExample() async {
        for await number in sequence {
            print(number)
        }
    }
}
