//
//  SpotlightLyricsCellViewModel.swift
//  SpotlightLyrics
//
//  Created by Scott Rong on 2017/7/28.
//  Copyright © 2017年 jayasme. All rights reserved.
//

import UIKit

public class LyricsCellViewModel {
    
    public static func cellViewModel(lyric: String, font: UIFont, textColor: UIColor) -> LyricsCellViewModel{
        return LyricsCellViewModel(lyric: lyric, font: font, textColor: textColor)
    }
    
    fileprivate init(lyric: String, font: UIFont, textColor: UIColor) {
        self.lyric = lyric
        self.font = font
        self.textColor = textColor
    }
    
    public var lyric: String {
        didSet {
            cell?.textLabel?.text = lyric
        }
    }
    public var font: UIFont {
        didSet {
            cell?.textLabel?.font = font
        }
    }
    public var textColor: UIColor {
        didSet {
            cell?.textLabel?.textColor = textColor
        }
    }
    public var highlighted: Bool = false {
        didSet {
            cell?.isHighlighted = highlighted
        }
    }
    public weak var cell: LyricsCell? = nil
}
