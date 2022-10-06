import Foundation

public typealias WeakAmplifyAsyncSequenceRef<Element> = WeakRef<AmplifyAsyncSequence<Element>>

public class AmplifyAsyncSequence<Element: Sendable>: AsyncSequence, Cancellable {
    public typealias Iterator = AsyncStream<Element>.Iterator
    private var asyncStream: AsyncStream<Element>! = nil
    private var continuation: AsyncStream<Element>.Continuation! = nil
    private var parent: Cancellable? = nil
    
    public private(set) var isCancelled: Bool = false

    public init(parent: Cancellable? = nil,
                bufferingPolicy: AsyncStream<Element>.Continuation.BufferingPolicy = .unbounded) {
        self.parent = parent
        asyncStream = AsyncStream<Element>(Element.self, bufferingPolicy: bufferingPolicy) { continuation in
            self.continuation = continuation
        }
    }

    public func makeAsyncIterator() -> Iterator {
        asyncStream.makeAsyncIterator()
    }

    public func send(_ element: Element) {
        continuation.yield(element)
    }

    public func finish() {
        continuation.finish()
        parent = nil
    }

    public func cancel() {
        guard !isCancelled else { return }
        isCancelled = true
        parent?.cancel()
        finish()
    }
}


import Foundation
import _Concurrency

/// The conforming type supports cancelling an in-process operation. The exact semantics of "canceling" are not defined
/// in the protocol. Specifically, there is no guarantee that a `cancel` results in immediate cessation of activity.
public protocol Cancellable {
    func cancel()
}

/// Unique name for Cancellable which handles a name conflict with the Combine framework.
public typealias AmplifyCancellable = Cancellable

extension _Concurrency.Task: AmplifyCancellable {}


public class WeakRef<T: AnyObject> {
    public weak var value: T?
    public init(_ value: T?) {
        self.value = value
    }
}
