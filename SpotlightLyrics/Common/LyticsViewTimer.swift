//
//  LyticsViewTimer.swift
//  SpotlightLyrics
//
//  Created by Scott Rong on 2018/12/7.
//  Copyright © 2018 Scott Rong. All rights reserved.
//

public final class LyricsViewTimer {
    
    private let TICK_INTERVAL: TimeInterval = 0.1
    
    private var timer: Timer? = nil
    
    internal weak var lyricsView: LyricsView? = nil
    
    private var elapsedTime: TimeInterval = 0
    
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
    
    public func reset() {
        pause()
        elapsedTime = .zero
    }
    
    public func seek(toTime time: TimeInterval) {
        elapsedTime = time
        lyricsView?.scroll(toTime: time, animated: true)
    }
    
    // MARK: tick
    
    @objc private func tick() {
        elapsedTime += TICK_INTERVAL
        seek(toTime: elapsedTime)
    }
}
