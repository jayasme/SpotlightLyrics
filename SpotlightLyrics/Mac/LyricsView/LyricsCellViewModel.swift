//
//  LyricsCellViewModel.swift
//  SpotlightLyrics
//
//  Created by Lyt on 9/28/20.
//

internal final class LyricsCellViewModel {

    // MARK: Properties

    public var lyric: String {
        didSet {
            update()
        }
    }

    public var font: NSFont {
        didSet {
            update()
        }
    }

    public var highlightedFont: NSFont {
        didSet {
            update()
        }
    }

    public var textColor: NSColor {
        didSet {
            update()
        }
    }

    public var highlightedTextColor: NSColor {
        didSet {
            update()
        }
    }

    public var highlighted: Bool = false {
        didSet {
            cell?.isHighlighted = highlighted
        }
    }

    public static func cellViewModel(lyric: String, font: NSFont, highlightedFont: NSFont, textColor: NSColor, highlightedTextColor: NSColor) -> LyricsCellViewModel {
        return LyricsCellViewModel(lyric: lyric,
                                   font: font,
                                   highlightedFont: highlightedFont,
                                   textColor: textColor,
                                   highlightedTextColor: highlightedTextColor)
    }

    fileprivate init(lyric: String, font: NSFont, highlightedFont: NSFont, textColor: NSColor, highlightedTextColor: NSColor) {
        self.lyric = lyric
        self.font = font
        self.highlightedFont = highlightedFont
        self.textColor = textColor
        self.highlightedTextColor = highlightedTextColor
        update()
    }

    private func update() {
        // produce the attributedString
        attributedString = NSAttributedString(string: lyric, attributes: [.font: font])
        highlightedAttributedString = NSAttributedString(string: lyric, attributes: [.font: highlightedFont])
        cell?.update(with: self)
    }

    public var attributedString: NSAttributedString? = nil
    public var highlightedAttributedString: NSAttributedString? = nil

    public func calcHeight(containerWidth: CGFloat) -> CGFloat {
        let boundingSize = CGSize(width: containerWidth, height: 9999)
        if highlighted {
            return highlightedAttributedString?.boundingRect(with: boundingSize, options: .usesLineFragmentOrigin, context: nil).height ?? 0
        } else {
            return attributedString?.boundingRect(with: boundingSize, options: .usesLineFragmentOrigin, context: nil).height ?? 0
        }
    }

    internal weak var cell: LyricsCell? = nil
}
