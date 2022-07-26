//
//  File.swift
//
//
//  Created by Ameter, Chris on 6/21/22.
//

import Foundation

class Greeter {
    
    func sayHi() async throws {
        try? await Task.sleep(nanoseconds: NSEC_PER_SEC * 3)
        
        try Task.checkCancellation()
        
        print("hi")
    }
    
    func sayHiOrBye() async throws {
        try? await Task.sleep(nanoseconds: NSEC_PER_SEC * 3)
        
        guard !Task.isCancelled else {
            print("bye")
            return
        }
        
        print("hi")
    }
    
    func sayHello() {
        print("hello")
    }
}
