//
//  LyricsCell.swift
//  ONFoundation
//
//  Created by Scott Rong on 2017/4/2.
//  Copyright © 2017年 on. All rights reserved.
//

import UIKit


public class LyricsCell: UITableViewCell {
    
    private var lyricLabel: UILabel!
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitInit()
    }
    
    private func commitInit() {
        lyricLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        contentView.addSubview(lyricLabel)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        lyricLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
    
    public override var isHighlighted: Bool {
        didSet {
            lyricLabel.alpha = isHighlighted ? 1 : 0.4
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = nil
        selectionStyle = .none
    }
    
    public func update(with viewModel: LyricsCellViewModel) {
        lyricLabel.text = viewModel.lyric
        lyricLabel.font = viewModel.font
        lyricLabel.textColor = viewModel.textColor
        lyricLabel.sizeThatFits(CGSize(width: bounds.width, height: bounds.height))
        isHighlighted = viewModel.highlighted
        viewModel.cell = self
    }
}
