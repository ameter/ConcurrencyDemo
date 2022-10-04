
#if canImport(Combine)
import XCTest
import Combine
@testable import ConcurrencyDemo

class AsyncPublisherTests: XCTestCase {
    enum Failure: Error {
        case unluckyNumber
    }
    
    func fooBar(input: Int) async throws -> Int {
        try await Task.sleep(seconds: 2)
        try Task.checkCancellation()
        guard input != 13 else { throw Failure.unluckyNumber }
        return input
    }
    
    func testHubPublisher() async throws {
        let receivedValue = expectation(description: "received value")
        
        let sink = AsyncPublisher.create {
            try await self.fooBar(input: 7)
        }
        .sink { completion in
            print("received completion")
        } receiveValue: { value in
            print("received value: \(value)")
            receivedValue.fulfill()
        }
        
        await waitForExpectations(timeout: 10)
        sink.cancel()
    }
    
    func testSequencePublisher() async throws {
        let done = expectation(description: "done")
        
        let doubles = Doubles()
        
        let sink = AsyncPublisher.create(doubles)
            .sink { completion in
                print("received completion")
                done.fulfill()
            } receiveValue: { value in
                print("received value: \(value)")
            }
        
//        Task {
//            try await Task.sleep(seconds:12)
//            sink.cancel()
//            print("cancelled sink")
//        }
        
        
        await waitForExpectations(timeout: 1)
        sink.cancel()
    }
    
    func testFuture() async throws {
        let done = expectation(description: "done")
        
//        var sink: AnyCancellable?
        let sink = AsyncPublisher.create {
            try await self.fooBar(input: 7)
        }
        .sink { completion in
            print("received completion")
            done.fulfill()
        } receiveValue: { value in
            print("received value: \(value)")
        }
        
//        sink = nil
//        sink?.cancel()
        
        await waitForExpectations(timeout: 10)
        sink.cancel()
    }
}
#endif
