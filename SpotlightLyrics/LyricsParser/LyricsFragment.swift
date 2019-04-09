//
//  LyricsFragment.swift
//  SpotlightLyrics
//
//  Created by Scott Rong on 2019/3/13.
//  Copyright © 2019 Scott Rong. All rights reserved.
//

import Foundation


public struct LyricsFragment {
    
    public init(time: TimeInterval, text: String = "") {
        self.time = time
        self.text = text
    }
    
    public var time: TimeInterval
    public var text: String
}
