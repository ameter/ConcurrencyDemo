//
//  File.swift
//  
//
//  Created by Ameter, Chris on 8/12/22.
//

import Foundation

class Worker {
    var continuations: [CheckedContinuation<String, Never>] = []
    
    func taskToCancel() async throws -> String {
        await withTaskCancellationHandler {
            print("cancelled")
            terminateAll("cancelled")
        } operation: {
            await withCheckedContinuation { continuation in
                continuations.append(continuation)
            }
        }
    }

    func terminateAll(_ value: String = "terminated") {
        for continuation in continuations {
            continuation.resume(returning: value)
        }
    }
}
