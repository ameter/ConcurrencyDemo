

#if canImport(Combine)
import Combine

class AsyncPublisher {
    static func create<Success>(
        operation: @escaping @Sendable () async throws -> Success
    ) -> AnyPublisher<Success, Error> {
        let task = Task(operation: operation)
        
        return Future() { promise in
            Task {
                do {
                    let value = try await task.value
                    promise(.success(value))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .handleEvents(receiveCancel: { task.cancel() } )
        .eraseToAnyPublisher()
    }
    
    static func create<Sequence: AsyncSequence>(
        _ sequence: Sequence
    ) -> AnyPublisher<Sequence.Element, Error> {
        let subject = PassthroughSubject<Sequence.Element, Error>()
        let task = Task {
            do {
                // If the Task is cancelled, this will allow the onCancel closure to be called immediately.
                // This is necessary to prevent continuing to wait until another value is received from
                // the sequence before cancelling in the case of a slow Iterator.
                try await withTaskCancellationHandler {
                    for try await value in sequence {
                        // If the Task is cancelled, this will end the loop and send a CancellationError
                        // via the publisher.
                        // This is necessary to prevent the sequence from continuing to send values for a time
                        // after cancellation in the case of a fast Iterator.
                        try Task.checkCancellation()
                        
                        subject.send(value)
                    }
                    subject.send(completion: .finished)
                } onCancel: {
                    // If the Task is cancelled and the AsyncSequence is Cancellable, as
                    // is the case with AmplifyAsyncSequence, cancel the AsyncSequence.
                    if let cancellable = sequence as? Cancellable {
                        cancellable.cancel()
                    }
                }
            } catch {
                subject.send(completion: .failure(error))
            }
        }
        return subject
            .handleEvents(receiveCancel: { task.cancel() })
            .eraseToAnyPublisher()
    }
}


#endif
