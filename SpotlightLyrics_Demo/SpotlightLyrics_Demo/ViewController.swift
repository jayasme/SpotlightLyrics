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
        
        lyricsView.lyrics = "dsddsdsd"
        lyricsView.font = UIFont.systemFont(ofSize: 15)
        lyricsView.textColor = UIColor.black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

