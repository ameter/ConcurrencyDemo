//
//  File.swift
//
//
//  Created by Ameter, Chris on 6/21/22.
//

import Foundation

class Greeter {
    
    func sayHi() async {
        try? await Task.sleep(nanoseconds: NSEC_PER_SEC * 3)
        print("hi")
    }
    
    func sayHello() {
        print("hello")
    }
}
