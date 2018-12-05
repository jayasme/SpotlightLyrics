//
//  SpotlightLyricsCellViewModel.swift
//  SpotlightLyrics
//
//  Created by Scott Rong on 2017/7/28.
//  Copyright © 2017年 jayasme. All rights reserved.
//

import UIKit

internal class LyricsCellViewModel {
    
    // MARK: Properties
    
    public var lyric: String {
        didSet {
            cell?.update(with: self)
        }
    }
    
    public var font: UIFont {
        didSet {
            cell?.update(with: self)
        }
    }
    
    public var highlightedFont: UIFont {
        didSet {
            cell?.update(with: self)
        }
    }
    
    public var textColor: UIColor {
        didSet {
            cell?.update(with: self)
        }
    }
    
    public var highlightedTextColor: UIColor {
        didSet {
            cell?.update(with: self)
        }
    }
    
    public var highlighted: Bool = false {
        didSet {
            cell?.isHighlighted = highlighted
        }
    }
    
    public static func cellViewModel(lyric: String, font: UIFont, highlightedFont: UIFont, textColor: UIColor, highlightedTextColor: UIColor) -> LyricsCellViewModel{
        return LyricsCellViewModel(lyric: lyric,
                                   font: font,
                                   highlightedFont: highlightedFont,
                                   textColor: textColor,
                                   highlightedTextColor: highlightedTextColor)
    }
    
    fileprivate init(lyric: String, font: UIFont, highlightedFont: UIFont, textColor: UIColor, highlightedTextColor: UIColor) {
        self.lyric = lyric
        self.font = font
        self.highlightedFont = highlightedFont
        self.textColor = textColor
        self.highlightedTextColor = highlightedTextColor
    }
    
    internal weak var cell: LyricsCell? = nil
}
