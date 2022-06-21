//
//  File.swift
//  
//
//  Created by Ameter, Chris on 6/21/22.
//

import Foundation

struct Doubles: AsyncSequence {
    typealias Element = Int

    struct AsyncIterator: AsyncIteratorProtocol {
        var current = 1

        mutating func next() async -> Element? {
            defer { current *= 2 }

            if current > 1024 {
                return nil
            } else {
                return current
            }
        }
    }

    func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator()
    }
}
