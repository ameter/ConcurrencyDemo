//
//  File.swift
//  
//
//  Created by Ameter, Chris on 6/21/22.
//

import Foundation

enum Oops: Error {
    case wtf
}

struct Doubles: AsyncSequence {
    typealias Element = Int

    struct AsyncIterator: AsyncIteratorProtocol {
        var current = 1

        mutating func next() async throws -> Element? {
            defer { current *= 2 }

//            try await Task.sleep(nanoseconds: 10 * NSEC_PER_SEC)
            
            if current > 1024 {
                return nil
            } else {
                return current
//                throw Oops.wtf
            }
        }
    }

    func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator()
    }
}
