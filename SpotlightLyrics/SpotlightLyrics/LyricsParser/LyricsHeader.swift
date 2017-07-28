//
//  LyricsHeader.swift
//  SpotlightLyrics
//
//  Created by Scott Rong on 2017/7/28.
//  Copyright © 2017年 jayasme. All rights reserved.
//

import Foundation

public struct LyricsHeader {
    // ti
    public var title: String?
    // ar
    public var author: String?
    // al
    public var album: String?
    // by
    public var by: String?
    // offset
    public var offset: TimeInterval = 0
    // re
    public var editor: String?
    // ve
    public var version: String?
}
