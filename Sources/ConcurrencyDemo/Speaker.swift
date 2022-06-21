//
//  File.swift
//  
//
//  Created by Ameter, Chris on 6/21/22.
//

import Foundation

protocol Speaker {
    func speak() async
}

class Mandalorian: Speaker {
    func speak() {
        print("I have spoken.")
    }
    
    func speak() async {
        print("I have spoken asynchronously.")
    }
}

class SpecialGuest<MysterySpeaker: Speaker> {
    let guest: MysterySpeaker
    
    init(_ guest: MysterySpeaker) {
        self.guest = guest
    }
    
    func begin() async {
        await guest.speak()
    }
}
