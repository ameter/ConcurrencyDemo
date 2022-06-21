//
//  File.swift
//  
//
//  Created by Ameter, Chris on 6/21/22.
//

import Foundation

actor TomHanks {
    func gump() {
        print("My mama always said, life was like a box of chocolates. You never know what you're gonna get.")
    }
    
    func speak() {
        gump()
    }
    
    nonisolated func speakAsync() async {
        await gump()
    }
    
    nonisolated func speakFreely() {
        Task {
            await gump()
        }
    }
    
    func perform(script: @escaping () -> Void) {
        script()
    }
    
    func performSafely(script: @Sendable @escaping () -> Void) {
        script()
    }
    
}
