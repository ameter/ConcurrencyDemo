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
    
    func sayHiOrBye() async {
        try? await Task.sleep(nanoseconds: NSEC_PER_SEC * 3)
        
        if !Task.isCancelled {
            print("hi")
        } else {
            print("bye")
        }
    }
    
    func sayHello() {
        print("hello")
    }
    
    func sayHelloOrGoodbye() {
        if !Task.isCancelled {
            print("hello")
        } else {
            print("goodbye")
        }
    }
}
