//
//  CombineTests.swift
//  
//
//  Created by Ameter, Chris on 7/21/22.
//

import XCTest
@testable import ConcurrencyDemo

class PipelineTests: XCTestCase {

    let engine = StateMachineEngine()

    override func setUp() async throws {

    }

    func testPipeline() async throws {
        print("testing pipeline")
        
        let pipeline = Pipeline()
        
        pipeline.multiply()
    }
    
    func testStateMachine() async throws {
        
        
        stateMachine.notify(action: .receivedStart)
        
        
    }
}
