//
//  WorkerTests.swift
//  
//
//  Created by Ameter, Chris on 8/12/22.
//

import XCTest
@testable import ConcurrencyDemo


final class WorkerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCancellation() async throws {
        let worker = Worker()
        let notYetDone = expectation(description: "not yet done")
        notYetDone.isInverted = true
        let task = Task {
            let response = try await worker.taskToCancel()
            notYetDone.fulfill()
            return response
        }
        
        await waitForExpectations(timeout: 0.1)
        
        worker.terminateAll()
        //task.cancel()
        
        let waitForCancellation = expectation(description: "Task was cancelled")
        Task {
            let response = try await task.value
            XCTAssertEqual(response, "terminated")
            waitForCancellation.fulfill()
        }
        
        await waitForExpectations(timeout: 1.0)
    }

}
