//
//  LyricsError.swift
//  SpotlightLyrics
//
//  Created by Scott Rong on 2017/7/28.
//  Copyright © 2017 Scott Rong. All rights reserved.
//

import Foundation


public struct LyricsLine {
    
    public init(time: TimeInterval, fragments: [LyricsFragment] = []) {
        self.time = time
        self.fragments = fragments
    }
    
    public var time: TimeInterval
    public var fragments: [LyricsFragment]
}
