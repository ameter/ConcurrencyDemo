//
//  File.swift
//  
//
//  Created by Ameter, Chris on 7/21/22.
//

import Foundation
import Combine

class Pipeline {
    
    func multiply() {
        let _ = Just(5)
            .map { value -> String in
                // do something with the incoming value here and return a string
                let multiplier = 2
                let result = value * multiplier
                return "\(value) * \(multiplier) = \(result)"
            }
            .sink { receivedValue in
                // sink is the subscriber and terminates the pipeline
                Task {
                    print("The end result was \(receivedValue)")
                }
            }
    }
}
