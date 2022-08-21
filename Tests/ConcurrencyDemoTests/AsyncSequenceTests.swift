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

    func testExample() async throws {
        for try await number in sequence {
            print(number)
        }
    }
}
