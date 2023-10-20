//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer = Timer ()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer?
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        //progressBar.progress = 1.0
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            if secondsPassed < totalTime  {
                secondsPassed += 1
                let percentageProgress = Float(secondsPassed) / Float(totalTime)
                //print(percentageProgress)
                progressBar.progress = percentageProgress
                //print(percentageProgress)
                
            } else {
                timer.invalidate()
                titleLabel.text = "Done!"
                playSound(soundName: "alarm_sound")
                print("Done!")
            }
        }
    }
    
    func playSound(soundName: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

