//
//  ProtocolTests.swift
//  
//
//  Created by Ameter, Chris on 6/21/22.
//

import XCTest
@testable import ConcurrencyDemo

final class ProtocolTests: XCTestCase {
    let mando = Mandalorian()
    let guestSpeaker = SpecialGuest(Mandalorian())
    
    func testSpeak() {
        mando.speak()
    }
    
    func testSpeakAsync() async {
        await mando.speak()
    }
    
    func testGuestSpeaker() async {
        await guestSpeaker.begin()
    }
}
