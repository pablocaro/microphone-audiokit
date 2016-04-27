//
//  ViewController.swift
//  160427-microphone
//
//  Created by Pablo Caro on 4/27/16.
//  Copyright © 2016 Pablo Caro. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    
    
    let mic = AKMicrophone()
    var tracker: AKFrequencyTracker?
    var silence: AKBooster? // this is to silence the output
    
    let minimum: Double = 60
    let maximum: Double = 800
    
    var timer = NSTimer()
    var increment:Double = 0
    
    @IBOutlet weak var labelFrequency: UILabel!
    @IBOutlet weak var labelAmplitude: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AKSettings.audioInputEnabled = true
        tracker = AKFrequencyTracker(mic, minimumFrequency: minimum, maximumFrequency: maximum)
        silence = AKBooster(tracker!, gain: 0)
        AudioKit.output = silence
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(ViewController.measureFrequency), userInfo: nil, repeats: true)
        

        
        AudioKit.start()
        mic.start()
        tracker?.start()

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func measureFrequency() {
        print("NSTimer Fired \(increment)")
        print("mic on: \(mic.isStarted)")
        
        if let frequency = tracker?.frequency {
            print("frequency: \(frequency)")
            labelFrequency.text = String(frequency)
        }
        
        if let amplitude = tracker?.amplitude {
            print("amplitude: \(amplitude)")
            labelAmplitude.text = String(amplitude)
        }
        
        increment += 0.5
    }


}



