//
//  File.swift
//
//
//  Created by Ameter, Chris on 6/21/22.
//

import XCTest
@testable import ConcurrencyDemo

class ConcurrentTasksTests: XCTestCase {
    let greeter = Greeter()
    
    func testNonConcurrent() async throws {
        try await greeter.sayHi()
        greeter.sayHello()
        try await greeter.sayHi()
        print("done")
    }

    func testTask() async throws {
        let task = Task { try await greeter.sayHi() }
        let task2 = Task { try await greeter.sayHi() }
        _ = await task.result
        _ = await task2.result
        print("done")
    }
    
    func testAyncLet() async throws {
        async let hello: Void = greeter.sayHi()
        async let hello2: () = greeter.sayHi()
        try await hello
        try await hello2
        print("done")
    }

    func testTaskGroup() async throws {
        await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask { [weak self] in
                try await self?.greeter.sayHi()
            }
            group.addTask { [weak self] in
                try await self?.greeter.sayHi()
            }
        }
        print("done")
    }
}
