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
    
    func testSync() throws {
        Task {
            await taskQueue.sync {
                await self.call()
            }
        }
    }
    
    func testAsync() throws {
        taskQueue.async {
            await self.call()
        }
    }
    
    func testSyncThrows() throws {
        Task {
            await taskQueue.sync {
                do {
                    try await self.throwingCall()
                } catch {
                    print(error)
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
    }
    
    // MARK: - Helpers
    
    private func call() async {
        print("Function: \(#function)")
    }
    
    private func throwingCall() async throws {
        print("Function: \(#function)")
        throw taskError.boom
    }
}

enum taskError: Error {
    case boom
}
