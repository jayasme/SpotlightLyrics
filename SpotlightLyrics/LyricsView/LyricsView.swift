//
//  LyricsView.swift
//  ONFoundation
//
//  Created by Scott Rong on 2017/4/2.
//  Copyright © 2017年 on. All rights reserved.
//

import UIKit


public class LyricsView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    private var parser: LyricsParser? = nil
    
    private var lyricsViewModels: [LyricsCellViewModel] = []
    
    private var lastIndex: Int? = nil
    
    // MARK: Public properties
    
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
    
    public var lyrics: String? = nil {
        didSet {
            reloadViewModels()
        }
    }
    
    public var lyricFont: UIFont = .systemFont(ofSize: 16) {
        didSet {
            reloadViewModels()
        }
    }
    
    public var lyricHighlightedFont: UIFont = .systemFont(ofSize: 16) {
        didSet {
            reloadViewModels()
        }
    }
    
    public var lyricTextColor: UIColor = .black {
        didSet {
            reloadViewModels()
        }
    }
    
    public var lyricHighlightedTextColor: UIColor = .lightGray {
        didSet {
            reloadViewModels()
        }
    }
    
    public var lineSpacing: CGFloat = 16 {
        didSet {
            reloadViewModels()
        }
    }
    
    // Initializations
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        register(LyricsCell.self, forCellReuseIdentifier: "LyricsCell")
        separatorStyle = .none
        clipsToBounds = true
        
        dataSource = self
        delegate = self
    }
    
    // MARK: UITableViewDataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lyricsViewModels.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 24
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: "LyricsCell", for: indexPath) as! LyricsCell
        cell.update(with: lyricsViewModels[indexPath.row])
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // MARK:
    
    private func reloadViewModels() {
        lyricsViewModels.removeAll()
        
        guard let lyrics = self.lyrics?.emptyToNil() else {
            reloadData()
            return
        }
        
        parser = LyricsParser(lyrics: lyrics)
        
        for lyric in parser!.lyrics {
            let viewModel = LyricsCellViewModel.cellViewModel(lyric: lyric.lyric,
                                                              font: lyricFont,
                                                              highlightedFont: lyricHighlightedFont,
                                                              textColor: lyricTextColor,
                                                              highlightedTextColor: lyricHighlightedTextColor
            )
            lyricsViewModels.append(viewModel)
        }
        reloadData()
        contentInset = UIEdgeInsets(top: frame.height / 2, left: 0, bottom: frame.height / 2, right: 0)
    }
    
    public func scroll(toTime time: TimeInterval, animated: Bool) {
        guard let lyrics = parser?.lyrics else {
            return
        }
        
        guard let index = lyrics.index(where: { $0.time >= time }) else {
            // when no lyric is before the time passed in means scrolling to the first
            if (lyricsViewModels.count > 0) {
                scrollToRow(at: IndexPath(row: 0, section: 0), at: .middle, animated: animated)
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
            scrollToRow(at: IndexPath(row: index - 1, section: 0), at: .middle, animated: animated)
            lastIndex = index - 1
        }
    }
}
