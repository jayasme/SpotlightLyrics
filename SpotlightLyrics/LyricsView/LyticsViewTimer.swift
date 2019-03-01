//
//  LyticsViewTimer.swift
//  SpotlightLyrics
//
//  Created by Scott Rong on 2018/12/7.
//  Copyright © 2018 Scott Rong. All rights reserved.
//

import UIKit


public class LyricsViewTimer {
    
    private let TICK_INTERVAL: TimeInterval = 0.1
    
    private var timer: Timer? = nil
    
    internal weak var lyricsView: LyricsView? = nil
    
    private var eplasedTime: TimeInterval = 0
    
    // MARK: Controls
    
    public func play() {
        guard timer == nil else {
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: TICK_INTERVAL, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    public func pause() {
        guard timer != nil else {
            return
        }
        
        timer?.invalidate()
        timer = nil
    }
    
    public func seek(toTime time: TimeInterval) {
        eplasedTime = time
        lyricsView?.scroll(toTime: time, animated: true)
    }
    
    // MARK: tick
    
    @objc private func tick() {
        eplasedTime += TICK_INTERVAL
        seek(toTime: eplasedTime)
    }
}
