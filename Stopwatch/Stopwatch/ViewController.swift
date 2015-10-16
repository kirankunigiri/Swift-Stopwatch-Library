//
//  ViewController.swift
//  Stopwatch
//
//  Created by Kiran Kunigiri on 10/15/15.
//  Copyright © 2015 Kiran Kunigiri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Properties
    @IBOutlet weak var stopwatchLabel: UILabel!
    var stopwatch: LabelStopwatch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the stopwatch with the stopwatchLabel
        stopwatch = LabelStopwatch(label: stopwatchLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // Start button action
    @IBAction func startButtonPressed(sender: UIButton) {
        stopwatch.start()
    }
    
    // Pause button action
    @IBAction func pauseButtonPressed(sender: UIButton) {
        stopwatch.pause()
    }
    
    // Stop button pressed
    @IBAction func stopButtonPressed(sender: UIButton) {
        stopwatch.stop()
    }
}

