//
//  LyricsError.swift
//  SpotlightLyrics
//
//  Created by Scott Rong on 2017/7/28.
//  Copyright © 2017年 jayasme. All rights reserved.
//

import Foundation


public class LyricsItem {
    
    public init(time: TimeInterval, lyric: String = "") {
        self.time = time
        self.lyric = lyric
    }
    
    public var time: TimeInterval
    public var lyric: String
}
