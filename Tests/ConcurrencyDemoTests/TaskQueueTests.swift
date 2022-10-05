//
//  File.swift
//
//
//  Created by Ameter, Chris on 6/21/22.
//

import XCTest
@testable import ConcurrencyDemo

@available(iOS 13.0.0, *)
class TaskQueueTests: XCTestCase {
    
    let taskQueue = TaskQueue<Void>()
    
    func testSync() async throws {
        print("starting")
        
        try await taskQueue.sync {
            try? await Task.sleep(nanoseconds: 3 * NSEC_PER_SEC)
            await self.call()
        }
        
        print("done")
    }
    
    func testMultipleCalls() {
        let finished1 = expectation(description: "finished 1")
        let finished2 = expectation(description: "finished 2")
        let finished3 = expectation(description: "finished 3")
        let finished4 = expectation(description: "finished 4")
        
        Task {
            print("starting 1")
            
            try await taskQueue.sync {
                try? await Task.sleep(nanoseconds: 7 * NSEC_PER_SEC)
                try? await self.call(1)
            }
            
            print("done 1")
            finished1.fulfill()
        }
        
        Task {
            print("starting 2")
            
            try await taskQueue.sync {
                try? await Task.sleep(nanoseconds: 5 * NSEC_PER_SEC)
                try? await self.call(2)
            }
            
            print("done 2")
            finished2.fulfill()
        }
        
        Task {
            print("starting 3")
            
            try await taskQueue.sync {
                try? await Task.sleep(nanoseconds: 3 * NSEC_PER_SEC)
                try? await self.call(3)
            }
            
            print("done 3")
            finished3.fulfill()
        }
        
        Task {
            print("starting 4")
            
            try await taskQueue.sync {
                try? await Task.sleep(nanoseconds: 1 * NSEC_PER_SEC)
                try? await self.call(4)
            }
            
            print("done 4")
            finished4.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testAsync() throws {
        taskQueue.async {
            await self.call()
        }
    }
    
    func testSyncThrows() throws {
        Task {
            try await taskQueue.sync {
                do {
                    try await self.throwingCall()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func testAsyncThrows() throws {
        taskQueue.async {
            do {
                try await self.throwingCall()
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - Helpers
    
    private func call() async {
        print("Function: \(#function)")
    }
    
    private func throwingCall() async throws {
        print("Function: \(#function)")
        throw taskError.boom
    }
    
    private func call(_ number: Int) async throws {
        if number == 2 {
            throw taskError.boom
        }
        print("Function: \(#function) \(number)")
    }
}

enum taskError: Error {
    case boom
}
