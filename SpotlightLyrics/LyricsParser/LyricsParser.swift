//
//  LyricsParser.swift
//  SpotlightLyrics
//
//  Created by Scott Rong on 2017/4/2.
//  Copyright © 2017 Scott Rong. All rights reserved.
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
            var headers: [String] = []
            
            if let title = header.title {
                headers.append(title)
            }
            
            if let author = header.author {
                headers.append(author)
            }
            if let album = header.album {
                headers.append(album)
            }
            if let by = header.by {
                headers.append(by)
            }
            if let editor = header.editor {
                headers.append(editor)
            }
            
            let intervalPerHeader = self.lyrics[0].time / TimeInterval(headers.count)
            
            var headerLyrics: [LyricsItem] = headers.enumerated().map { LyricsItem(time: intervalPerHeader * TimeInterval($0.offset), text: $0.element) }
            if (headerLyrics.count > 0) {
                headerLyrics.append(LyricsItem(time: intervalPerHeader * TimeInterval(headerLyrics.count), text: ""))
            }
            
            self.lyrics.insert(contentsOf: headerLyrics, at: 0)
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
            let startIndex = line.index(line.startIndex, offsetBy: prefix.count + 2)
            let endIndex = line.index(line.endIndex, offsetBy: -1)
            return String(line[startIndex..<endIndex])
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
            let amidString = String(cLine[startIndex..<endIndex])
            
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
            items.append(LyricsItem(time: 0, text: line))
        }

        items.forEach{ $0.text = cLine }
        return items
    }
}
