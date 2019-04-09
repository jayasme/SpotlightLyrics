//
//  LyricsCellProtocol.swift
//  SpotlightLyrics
//
//  Created by Scott Rong on 2019/4/9.
//  Copyright © 2019 Scott Rong. All rights reserved.
//

import Foundation

public protocol LyricsCellProtocol {

    var progress: Int { get set }
    
    var lyric: String { get set }
    
    var highlighted: Bool { get set }
}
