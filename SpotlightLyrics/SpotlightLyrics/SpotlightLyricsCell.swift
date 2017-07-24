//
//  LyricsCell.swift
//  ONFoundation
//
//  Created by Scott Rong on 2017/4/2.
//  Copyright © 2017年 on. All rights reserved.
//

import Foundation


public class LyricsCell: ONTableViewCell {
    
    @IBOutlet weak var lyricLabel: UILabel!
    
    public override func commonInit() {
        backgroundColor = nil
    }
    
    public override func updateViewModel(viewModel: CellViewModel) {
        super.updateViewModel(viewModel: viewModel)
        if let viewModel = viewModel as? LyricsCellViewModel {
            lyricLabel.text = viewModel.lyric
            lyricLabel.font = viewModel.font
            lyricLabel.textColor = viewModel.textColor
            lyricLabel.alpha = viewModel.highlighted ? 1 : 0.4
        }
    }
}
