//
//  LyricsCell.swift
//  SpotlightLyrics
//
//  Created by Scott Rong on 2017/4/2.
//  Copyright © 2017 Scott Rong. All rights reserved.
//

import UIKit


internal class LyricsCell: UITableViewCell {
    
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
        lyricLabel.textAlignment = .center
        selectionStyle = .none
        contentView.addSubview(lyricLabel)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        lyricLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
    
    public override var isHighlighted: Bool {
        didSet {
            applyViewModel()
        }
    }
    
    public func update(with viewModel: LyricsCellViewModel) {
        self.viewModel = viewModel
    }
    
    private func applyViewModel() {
        guard let viewModel = self.viewModel else {
            return
        }
        
        lyricLabel.attributedText = isHighlighted ? viewModel.highlightedAttributedString : viewModel.attributedString
        lyricLabel.sizeThatFits(CGSize(width: bounds.width, height: bounds.height))
        
        viewModel.cell = self
    }
    
    private weak var viewModel : LyricsCellViewModel? = nil
}
