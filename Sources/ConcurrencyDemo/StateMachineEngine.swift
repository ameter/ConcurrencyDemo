//
//  File.swift
//  
//
//  Created by Ameter, Chris on 7/21/22.
//

import Foundation
import Combine

class StateMachineEngine {
    
    let stateMachine: StateMachine<EngineState, EngineAction>
    private var stateMachineSink: AnyCancellable?
    
    init() {
        stateMachine = StateMachine(initialState: .notStarted, resolver: EngineResolver.resolve(currentState: action:))
        
        stateMachineSink = self.stateMachine
            .$state
            .sink { [weak self] newState in
                print("blah 1: \(newState)")
                Task { [weak self] in
                    
                    print("blah 2")
                    
                    guard let self = self else { return }
                    
                    print("New state: \(newState)")
                    //                    self.workQueue.async {
                    self.respond(to: newState)
                    //                    }
                }
            }
    }
    
    /// Listens to incoming state changes and invokes the appropriate asynchronous methods in response.
    private func respond(to newState: EngineState) {
        print("\(#function): \(newState)")

        switch newState {
        case .notStarted:
            break

        case .running:
            finish()

        case .finished:
            reset()
        }
    }
    
    
    func start() {
        //remoteSyncTopicPublisher.send(.storageAdapterAvailable)
        stateMachine.notify(action: .receivedStart)
    }

    func stop() {
        stateMachine.notify(action: .finished)
    }

}

/// States are descriptive, they say what is happening in the system right now
enum EngineState {
    case notStarted
    case running
    case finished

    var displayName: String {
        switch self {
        case .notStarted:
            return "notStarted"
        case .running:
            return "running"
        case .finished:
            return "finished"
        }
    }
}

/// Actions are declarative, they say what I just did
enum EngineAction {
    case receivedStart
    case receivedCancel
    case finished

    var displayName: String {
        switch self {
        case .receivedStart:
            return "receivedStart"
        case .receivedCancel:
            return "receivedCancel"
        case .finished:
            return "finished"
        }

    }
}

struct EngineResolver {
    static func resolve(currentState: EngineState, action: EngineAction) -> EngineState {
        switch (currentState, action) {
        case (.notStarted, .receivedStart):
            return .running

        case (.running, .receivedCancel):
            return .finished

        case (_, .finished):
            return .notStarted

        default:
            print("Unexpected state transition. In \(currentState.displayName), got \(action.displayName)")
            return currentState
        }
    }
}
