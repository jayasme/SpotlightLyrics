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
    
    private var currentTime: TimeInterval = 0
    
    private let totalDuration: TimeInterval = 332
    
    private var currentTimeString: String {
        return String(format: "%.1fs / %.1fs", ceil(currentTime * 10) / 10, totalDuration)
    }

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
        
        timeLabel.text = currentTimeString
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
        
        currentTime = 100
        lyricsView.scroll(to: currentTime, animated: true)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (_) in
            self.lyricsView.scroll(to: self.currentTime, animated: true)
            self.currentTime += 0.5
            if (self.currentTime >= self.totalDuration) {
                self.stop()
            }
            self.timeLabel.text = self.currentTimeString
        })
    }
    
    private func stop() {
        playButton.isSelected = false
        self.currentTime = 0
        timeLabel.text = currentTimeString
        
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

