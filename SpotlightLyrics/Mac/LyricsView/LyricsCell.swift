//
//  LyricsCell.swift
//  SpotlightLyrics
//
//  Created by Lyt on 9/28/20.
//

import Foundation

open class LyricsCell: NSView {

    private var lyricLabel: NSTextField = {
        let textField = NSTextField(labelWithString: "")
        textField.isEditable = false
        textField.alignment = .center
        textField.maximumNumberOfLines = 0
        return textField
    }()

    init() {
        isHighlighted = false
        super.init(frame: .zero)
        setupLayout()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(lyricLabel)
        lyricLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lyricLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            lyricLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            lyricLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            lyricLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            lyricLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
    }

    public var isHighlighted: Bool {
        didSet {
            applyViewModel()
        }
    }

    func update(with viewModel: LyricsCellViewModel) {
        self.viewModel = viewModel
        applyViewModel()
    }

    private func applyViewModel() {
        guard let viewModel = self.viewModel else {
            return
        }

        if isHighlighted {
            lyricLabel.font = viewModel.highlightedFont
            lyricLabel.textColor = viewModel.highlightedTextColor
        } else {
            lyricLabel.font = viewModel.font
            lyricLabel.textColor = viewModel.textColor
        }
        //lyricLabel.attributedStringValue = (isHighlighted ? viewModel.highlightedAttributedString : viewModel.attributedString) ?? NSAttributedString(string: "")
        lyricLabel.stringValue = viewModel.lyric

        lyricLabel.sizeThatFits(CGSize(width: bounds.width, height: bounds.height))

        viewModel.cell = self
    }

    private weak var viewModel : LyricsCellViewModel? = nil
}
