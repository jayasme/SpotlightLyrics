//
//  ViewController.swift
//  SpotlightLyrics_Demo
//
//  Created by Scott Rong on 2017/7/24.
//  Copyright © 2017年 jayasme. All rights reserved.
//

import UIKit
import SpotlightLyrics

class ViewController: UIViewController {
    
    @IBOutlet weak var lyricsView: LyricsView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Read the test LRC file
        guard
            let path = Bundle.main.path(forResource: "Santa Monica Dream", ofType: "lrc"),
            let stream = InputStream(fileAtPath: path)
        else {
            return
        }
        
        var data = Data.init()
        
        stream.open()
        let bufferSize = 1024
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        while (stream.hasBytesAvailable) {
            let read = stream.read(buffer, maxLength: bufferSize)
            data.append(buffer, count: read)
        }
        stream.close()
        buffer.deallocate(capacity: bufferSize)
        let lyrics = String(data: data, encoding: .utf8)
        
        // Initialize the SpotlightLyrics view
        lyricsView.lyrics = lyrics
        lyricsView.font = UIFont.systemFont(ofSize: 15)
        lyricsView.textColor = UIColor.black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

