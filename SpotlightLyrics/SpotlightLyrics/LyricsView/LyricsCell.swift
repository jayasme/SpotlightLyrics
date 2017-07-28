//
//  LyricsCell.swift
//  ONFoundation
//
//  Created by Scott Rong on 2017/4/2.
//  Copyright © 2017年 on. All rights reserved.
//

import UIKit


public class LyricsCell: UITableViewCell {
    
    @IBOutlet weak var lyricLabel: UILabel!
    
    public override var isHighlighted: Bool {
        didSet {
            lyricLabel.alpha = isHighlighted ? 1 : 0.4
        }
    }
    
    public override func awakeFromNib() {
        backgroundColor = nil
    }
    
    public func update(with viewModel: LyricsCellViewModel) {
        lyricLabel.text = viewModel.lyric
        lyricLabel.font = viewModel.font
        lyricLabel.textColor = viewModel.textColor
        isHighlighted = viewModel.highlighted
        viewModel.cell = self
    }
}
