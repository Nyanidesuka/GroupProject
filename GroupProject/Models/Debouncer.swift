//
//  Debouncer.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/19/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

class Debouncer {
    
    /**
     Create a new Debouncer instance with the provided time interval.
     
     - parameter timeInterval: The time interval of the debounce window.
     */
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    typealias Handler = () -> Void
    
    /// Closure to be debounced.
    /// Perform the work you would like to be debounced in this handler.
    var handler: Handler?
    
    /// Time interval of the debounce window.
    private let timeInterval: TimeInterval
    
    private var timer: Timer?
    
    /// Indicate that the handler should be invoked.
    /// Begins the debounce window with the duration of the time interval parameter.
    func renewInterval() {
        // Invalidate existing timer if there is one
        timer?.invalidate()
        // Begin a new timer from now
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { [weak self] timer in
            self?.handleTimer(timer)
        })
    }
    
    private func handleTimer(_ timer: Timer) {
        guard timer.isValid else {
            return
        }
        handler?()
        handler = nil
    }
    
}
