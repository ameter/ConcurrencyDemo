//
//  CancellationTests.swift
//  
//
//  Created by Ameter, Chris on 7/26/22.
//

import XCTest
@testable import ConcurrencyDemo

final class CancellationTests: XCTestCase {

    let greeter = Greeter()

    func testCancelDefault() async {
        let task = Task {
            try await greeter.sayHi()
        }
        
        task.cancel()
        
        do {
            try await task.value
        } catch {
            if error is CancellationError {
                print("task was cancelled")
                return
            }
            XCTFail("task should have been cancelled")
        }
        XCTFail("task should have been cancelled")
    }
    
    func testCancelCustom() async throws {
        let task = Task {
            await greeter.sayHiOrBye()
        }
        
        task.cancel()
        await task.value
    }
    
    func testSyncFunction() {
        greeter.sayHelloOrGoodbye()
    }
    
    func testCancelSyncFunction() async {
        let task = Task {
            greeter.sayHelloOrGoodbye()
        }
        task.cancel()
        await task.value
    }
}
