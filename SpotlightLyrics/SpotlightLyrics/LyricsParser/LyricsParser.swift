//
//  LyricsParser.swift
//  ONFoundation
//
//  Created by Scott Rong on 2017/4/2.
//  Copyright © 2017年 on. All rights reserved.
//

import Foundation


public protocol LyricsManagerDelegate: class {
    
    func occoursError(error: Error)
}

public class LyricsParser {
    
    public var header: LyricsHeader
    public var lyrics: [LyricsItem] = []
    public var autor: String = ""
    
    // MARK: Initializers
    
    public init(lyrics: String) {
        header = LyricsHeader()
        commonInit(lyrics: lyrics)
    }
    
    
    private func commonInit(lyrics: String) {
        header = LyricsHeader()
        parse(lyrics: lyrics)
    }
    
    
    // MARK: Privates
    
    private func parse(lyrics: String) {
        let lines = lyrics
            .replacingOccurrences(of: "\\n", with: "\n")
            .trimmingCharacters(in: .quotes)
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: .newlines)
        
        for line in lines {
            parseLine(line: line)
        }
        
        // sort by time
        self.lyrics.sort{ $0.time < $1.time }
        
        // parse header into lyrics
        // insert header distribute by averge time intervals
        if self.lyrics.count > 0 {
            let headerCount =
                    (header.title == nil ? 0 : 1) +
                    (header.author == nil ? 0 : 1) +
                    (header.album == nil ? 0 : 1) +
                    (header.by == nil ? 0 : 1) +
                    (header.editor == nil ? 0 : 1)
            
            let intervalPerHeader = self.lyrics[0].time / TimeInterval(headerCount)
            if let title = header.title {
                self.lyrics.insert(LyricsItem(time: 0, lyric: title), at: 0)
            }
            if let author = header.author {
                self.lyrics.insert(LyricsItem(time: intervalPerHeader, lyric: author), at: 1)
            }
            if let album = header.album {
                self.lyrics.insert(LyricsItem(time: intervalPerHeader * 2, lyric: album), at: 2)
            }
            if let by = header.by {
                self.lyrics.insert(LyricsItem(time: intervalPerHeader * 3, lyric: by), at: 3)
            }
            if let editor = header.editor {
                self.lyrics.insert(LyricsItem(time: intervalPerHeader * 4, lyric: editor), at: 4)
            }
        }
        
    }
    
    private func parseLine(line: String) {
        guard let line = line.blankToNil() else {
            return
        }

        if let title = parseHeader(prefix: "ti", line: line) {
            header.title = title
            return
        }
        if let author = parseHeader(prefix: "ar", line: line) {
            header.author = author
            return
        }
        if let album = parseHeader(prefix: "al", line: line) {
            header.album = album
            return
        }
        if let by = parseHeader(prefix: "by", line: line) {
            header.by = by
            return
        }
        if let offset = parseHeader(prefix: "offset", line: line) {
            header.offset = TimeInterval(offset) ?? 0
            return
        }
        if let editor = parseHeader(prefix: "re", line: line) {
            header.editor = editor
            return
        }
        if let version = parseHeader(prefix: "ve", line: line) {
            header.version = version
            return
        }
        
        lyrics += parseLyric(line: line)
    }
    
    private func parseHeader(prefix: String, line: String) -> String? {
        if line.hasPrefix("[" + prefix + ":") && line.hasSuffix("]") {
            let startIndex = line.index(line.startIndex, offsetBy: prefix.length + 2)
            let endIndex = line.index(line.endIndex, offsetBy: -1)
            return line.substring(with: startIndex..<endIndex)
        } else {
            return nil
        }
    }
    
    private func parseLyric(line: String) -> [LyricsItem] {
        var cLine = line
        var items : [LyricsItem] = []
        while(cLine.hasPrefix("[")) {
            guard let closureIndex = cLine.range(of: "]")?.lowerBound else {
                break
            }
            
            let startIndex = cLine.index(cLine.startIndex, offsetBy: 1)
            let endIndex = cLine.index(closureIndex, offsetBy: -1)
            let amidString = cLine.substring(with: startIndex..<endIndex)
            
            let amidStrings = amidString.components(separatedBy: ":")
            var hour:TimeInterval = 0
            var minute: TimeInterval = 0
            var second: TimeInterval = 0
            if amidStrings.count >= 1 {
                second = TimeInterval(amidStrings[amidStrings.count - 1]) ?? 0
            }
            if amidStrings.count >= 2 {
                minute = TimeInterval(amidStrings[amidStrings.count - 2]) ?? 0
            }
            if amidStrings.count >= 3 {
                hour = TimeInterval(amidStrings[amidStrings.count - 3]) ?? 0
            }

            items.append(LyricsItem(time: hour * 3600 + minute * 60 + second + header.offset))
            
            cLine.removeSubrange(line.startIndex..<cLine.index(closureIndex, offsetBy: 1))
        }
        
        if items.count == 0 {
            items.append(LyricsItem(time: 0, lyric: line))
        }

        items.forEach{ $0.lyric = cLine }
        return items
    }
}
