//
//  Created by Ameter, Chris on 5/23/22.
//
#if swift(>=5.5.2)

import Foundation

@available(iOS 13.0, *)
public actor TaskQueue<Success> {
    private var previousTask: Task<Success, Error>?
    
    public init() {}

    public func sync(block: @Sendable @escaping () async throws -> Success) async throws -> Success {
        let currentTask: Task<Success, Error> = Task { [previousTask] in
            _ = await previousTask?.result
            return try await block()
        }
        previousTask = currentTask
        return try await currentTask.value
    }

    public nonisolated func async(block: @Sendable @escaping () async throws -> Success) rethrows {
        Task {
            try await sync(block: block)
        }
    }
}

#endif
