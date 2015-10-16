//
//  Stopwatch.swift
//  Stopwatch
//
//  Created by Kiran Kunigiri on 10/15/15.
//  Copyright © 2015 Kiran Kunigiri. All rights reserved.
//

import Foundation
import UIKit

// MARK: Stopwatch

class Stopwatch: NSObject {
    
    // Required Set Properties
    var timer = NSTimer()
    
    // Properties of the label string
    var strHours = "00"
    var strMinutes = "00"
    var strSeconds = "00"
    var strTenthsOfSecond = "00"
    
    // General
    var startTime = NSTimeInterval()
    var pauseTime = NSTimeInterval()
    var wasPause = false
    
    // Properties of actual values
    var numHours = 0
    var numMinutes = 0
    var numSeconds = 0
    var numTenthsOfSecond = 0
    
    var timeText = ""
    
    
    // MARK: Main Update Function
    func updateTime() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        // Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        // Calculate the hours in elapsed time.
        numHours = Int(elapsedTime / 3600.0)
        
        elapsedTime -= (NSTimeInterval(numHours) * 3600)
        
        // Calculate the minutes in elapsed time.
        numMinutes = Int(elapsedTime / 60.0)
        
        elapsedTime -= (NSTimeInterval(numMinutes) * 60)
        
        // Calculate the seconds in elapsed time.
        numSeconds = Int(elapsedTime)
        
        elapsedTime -= NSTimeInterval(numSeconds)
        
        // Finds out the number of milliseconds to be displayed.
        numTenthsOfSecond = Int(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        strHours = String(format: "%02d", numHours)
        strMinutes = String(format: "%02d", numMinutes)
        strSeconds = String(format: "%02d", numSeconds)
        strTenthsOfSecond = String(format: "%02d", numTenthsOfSecond)
        
    }
    
    
    // MARK: Setting Functions
    private func resetTimer() {
        startTime = NSDate.timeIntervalSinceReferenceDate()
        strHours = "00"
        strMinutes = "00"
        strSeconds = "00"
        strTenthsOfSecond = "00"
    }
    
    // MARK: Start/Stop Functions
    func start() {
        if !timer.valid {
            let aSelector: Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            
            if wasPause {
                startTime = NSDate.timeIntervalSinceReferenceDate() - startTime
            } else {
                startTime = NSDate.timeIntervalSinceReferenceDate()
            }
        }
    }
    
    func pause() {
        wasPause = true
        
        timer.invalidate()
        pauseTime = NSDate.timeIntervalSinceReferenceDate()
        startTime = pauseTime - startTime
    }
    
    func stop() {
        wasPause = false
        
        timer.invalidate()
        resetTimer()
    }
    
    
    // MARK: Value functions
    func getTimeInHours() -> Int {
        return numHours
    }
    
    func getTimeInMinutes() -> Int {
        return numHours * 60 + numMinutes
    }
    
    func getTimeInSeconds() -> Int {
        return numHours * 3600 + numMinutes * 60 + numSeconds
    }
    
    func getTimeInMilliseconds() -> Int {
        return numHours * 3600000 + numMinutes * 60000 + numSeconds * 1000 + numTenthsOfSecond * 100
    }
    
    
    
}


/*
 * MARK: LabelStopwatch
 * Subclass of Stopwatch
 *
 * Description: This class automatically updates any UILabel wih the stopwatch time. 
 * This makes it easier to use the stopwatch. All you have to do is create a 
 * LabelStopwatch and pass in your UILabel as the parameter. Then the LabelStopwatch 
 * will automatically update your label as you call the start, stop, or reset functions.
*/
class LabelStopwatch: Stopwatch {
    
    var label = UILabel()

    init(label: UILabel) {
        self.label = label
    }
    
    override func updateTime() {
        super.updateTime()
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        label.text = "\(strHours):\(strMinutes):\(strSeconds):\(strTenthsOfSecond)"
    }
    
    override func resetTimer() {
        super.resetTimer()
        label.text = "\(strHours):\(strMinutes):\(strSeconds):\(strTenthsOfSecond)"
    }
    
}






