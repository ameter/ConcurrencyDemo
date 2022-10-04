//
//  File.swift
//  
//
//  Created by Ameter, Chris on 6/21/22.
//

import XCTest
@testable import ConcurrencyDemo

internal protocol NoDep {
    func noway()
}
extension Blah: NoDep {}


public class Blah {
    @available(*, deprecated, message: "nope!")
    public func noway() {
        print("no way!")
    }
}

class ActorTests: XCTestCase {
    let hanks = TomHanks()
    var greeter = Greeter()
    var script = Script()

    func testGump() async {
        await hanks.gump()
    }
    
    func testSpeak() async {
        await hanks.speak()
    }
    
    func testSpeakAsync() async {
        await hanks.speakAsync()
    }
    
    func testSpeakFreely() {
        hanks.speakFreely()
    }
    
    func testPerform() async {
        await hanks.perform {
            print("Never give up because you never know what the tide will bring in the next day.")
        }
    }
    
    func testPerformGreeting() async {
        await hanks.perform(script: greeter.sayHello)
    }
    
    func testPerformSafely() async {
        await hanks.performSafely {
            print(self.script.castAway)
        }
    }
    
@available(*, deprecated, message: "nope!")
func testNoWay() {
    let blah = Blah()
    (blah as NoDep).noway()
}
    

}

class Script {
    var castAway = "Never give up because you never know what the tide will bring in the next day."
}
