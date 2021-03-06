//
//  TempoCounter.swift
//  ios-multiple-beacon-finder
//
//  Created by m.rakhmanov on 11.12.16.
//  Copyright © 2016 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

enum BeatStep: Int {
    case fourth = 4
    case eighth = 8
    case sixteenth = 16
    case thirtyTwo = 32
}

typealias Handler = () -> ()

class TempoCounter {
    private var displayLink: CADisplayLink!
    private let frameRate = 60
    private var internalCounter = 0
    
    var tempo = 120.0
    var beatStep = BeatStep.fourth
    var handlers: [Handler] = []
    
    var isRunning: Bool {
        return !displayLink.isPaused
    }
    
    private var nextTickLength: Int {
        return Int(Double(frameRate) / (tempo / 60.0 * Double(beatStep.rawValue) / 4.0))
    }
    
    init() {
        displayLink = CADisplayLink(target: self, selector: #selector(fire))
        if #available(iOS 10.0, *) {
            displayLink.preferredFramesPerSecond = frameRate
        } else {
            // Fallback on earlier versions
        }
        displayLink.add(to: RunLoop.main, forMode: .commonModes)
        displayLink.isPaused = true
    }
    
    func start() {
        displayLink.isPaused = false
    }
    
    func stop() {
        displayLink.isPaused = true
    }
    
    func addHandler(_ handler: @escaping Handler) {
        handlers.append(handler)
    }
    
    func removeLast() {
        guard handlers.count > 0 else { return }
        _ = handlers.remove(at: handlers.count - 1)
    }
    
    @objc func fire() {
        internalCounter += 1
        
        if internalCounter >= nextTickLength {
            internalCounter = 0
            
            for handler in handlers {
                handler()
            }
        }
    }
}
