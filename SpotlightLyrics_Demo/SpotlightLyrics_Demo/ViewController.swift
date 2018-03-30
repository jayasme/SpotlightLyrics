//
//  ViewController.swift
//  SpotlightLyrics_Demo
//
//  Created by Scott Rong on 2017/7/24.
//  Copyright © 2017年 jayasme. All rights reserved.
//

import UIKit
import SpotlightLyrics

class ViewController: UIViewController {
    
    @IBOutlet weak var lyricsView: LyricsView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    private var timer: Timer? = nil
    
    private var currentTimer: TimeInterval = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Read the test LRC file
        guard
            let path = Bundle.main.path(forResource: "Santa Monica Dream", ofType: "lrc"),
            let stream = InputStream(fileAtPath: path)
        else {
            return
        }
        
        var data = Data.init()
        
        stream.open()
        let bufferSize = 1024
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        while (stream.hasBytesAvailable) {
            let read = stream.read(buffer, maxLength: bufferSize)
            data.append(buffer, count: read)
        }
        stream.close()
        buffer.deallocate(capacity: bufferSize)
        let lyrics = String(data: data, encoding: .utf8)
        
        // Initialize the SpotlightLyrics view
        lyricsView.lyrics = lyrics
        lyricsView.font = UIFont.systemFont(ofSize: 13)
        lyricsView.textColor = UIColor.black
    }
    
    
    @IBAction func onStartButtonPress() {
        // unselected = stopped
        // selected = playing
        if (playButton.isSelected) {
            stop()
        } else {
            play()
        }
    }
    
    
    private func play() {
        playButton.isSelected = true
        
        if (timer != nil) {
            timer?.invalidate()
            timer = nil
        }
        
        currentTimer = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (_) in
            self.lyricsView.scroll(to: self.currentTimer, animated: true)
            self.currentTimer += 0.2
            self.timeLabel.text = String(self.currentTimer)
        })
    }
    
    private func stop() {
        playButton.isSelected = false
        
        if (timer != nil) {
            timer?.invalidate()
            timer = nil
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

