//
//  LyricsView.swift
//  ONFoundation
//
//  Created by Scott Rong on 2017/4/2.
//  Copyright © 2017年 on. All rights reserved.
//

import UIKit


public class LyricsView: ONTableView, ONTableViewFixedDataSource, ONTableViewDelegate {
    
    private var parser: LyricsParser? = nil
    
    private var lyricsViewModels: [LyricsCellViewModel] = []
    
    private var lastIndex: Int? = nil
    
    public var currentLyric: String? {
        get {
            guard let lastIndex = lastIndex else {
                return nil
            }
            guard lastIndex < lyricsViewModels.count else {
                return nil
            }
            
            return lyricsViewModels[lastIndex].lyric
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.onDataSource = self
        self.onDelegate = self
    }

    public var lyrics: String! {
        didSet {
            parser = LyricsParser(lyrics: lyrics)
            
            for lyric in parser!.lyrics {
                lyricsViewModels.append(LyricsCellViewModel.cellViewModel(lyric: lyric.lyric, font: font, textColor: textColor))
            }

            reloadViewModels(clearPreviousData: true)
            
            contentInset = UIEdgeInsets(top: frame.height / 2, left: 0, bottom: frame.height / 2, right: 0)
        }
    }
    
    
    public var font: UIFont = .systemFont(ofSize: 16) {
        didSet {
            reloadViewModels(clearPreviousData: true)
        }
    }
    
    public var textColor: UIColor = .black {
        didSet {
            reloadViewModels(clearPreviousData: true)
        }
    }
    

    
    public func retrieveData() -> [CellViewModel] {
        return lyricsViewModels
    }
    
    public func scroll(to time: TimeInterval, animated: Bool) {
        guard let lyrics = parser?.lyrics else {
            return
        }
        
        guard let index = lyrics.index(where: { $0.time >= time }) else {
            // no one is before the time passed in which means scrolling to the first
            if let first = lyricsViewModels.first {
                scrollToCellViewModel(first, at: .middle, animated: animated)
            }
            return
        }
        
        guard lastIndex == nil || index - 1 != lastIndex else {
            return
        }
        
        if let lastIndex = lastIndex {
            lyricsViewModels[lastIndex].highlighted = false
        }
        
        if index > 0 {
            lyricsViewModels[index - 1].highlighted = true
            scrollToCellViewModel(lyricsViewModels[index - 1], at: .middle, animated: animated)
            lastIndex = index - 1
        }
    }
}
