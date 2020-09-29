//
//  LyricsView.swift
//  SpotlightLyrics
//
//  Created by Lyt on 9/28/20.
//

open class LyricsView: NSView {

    private let cellIdentifier: NSUserInterfaceItemIdentifier = .init(rawValue: "LyricsCell")

    private var parser: LyricsParser? = nil

    private var lyricsViewModels: [LyricsCellViewModel] = []

    private var lastIndex: Int? = nil

    private(set) public var timer: LyricsViewTimer = LyricsViewTimer()

    private var scrollViewHadScrolledByUser = false

    private let scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        scrollView.drawsBackground = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()

    private lazy var tableView: NSTableView = {
        let tableView = NSTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.selectionHighlightStyle = .none
        tableView.headerView = nil
        tableView.gridColor = .clear
        tableView.wantsLayer = true
        tableView.backgroundColor = .clear
        return tableView
    }()

    // MARK: Public properties

    public var currentLyric: String? {
        get {
            guard let lastIndex = lastIndex else {
                return nil
            }
            guard lastIndex < lyricsViewModels.count else {
                return nil
            }

            return lyricsViewModels[lastIndex].lyric
        }
    }

    public var lyrics: String? = nil {
        didSet {
            reloadViewModels()
        }
    }

    public var lyricFont: NSFont = .systemFont(ofSize: 14) {
        didSet {
            reloadViewModels()
        }
    }

    public var lyricHighlightedFont: NSFont = .systemFont(ofSize: 24) {
        didSet {
            reloadViewModels()
        }
    }

    public var lyricTextColor: NSColor = .labelColor {
        didSet {
            reloadViewModels()
        }
    }

    public var lyricHighlightedTextColor: NSColor = .selectedTextColor {
        didSet {
            reloadViewModels()
        }
    }

    public var lineSpacing: CGFloat = 16 {
        didSet {
            reloadViewModels()
        }
    }

    // MARK: Initializations

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupBinding()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupBinding() {
        scrollView.postsFrameChangedNotifications = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollViewDidEndLiveScroll(notification:)),
                                               name: NSScrollView.willStartLiveScrollNotification,
                                               object: scrollView)
    }

    private func setupLayout() {
        timer.lyricsView = self

        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = tableView
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400)
        ])

        let column = NSTableColumn(identifier: cellIdentifier)
        column.minWidth = 400
        tableView.addTableColumn(column)
    }
}

extension LyricsView: NSTableViewDataSource {
    public func numberOfRows(in tableView: NSTableView) -> Int {
        lyricsViewModels.count
    }

    public func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let cellViewModel = lyricsViewModels[row]
        return lineSpacing + cellViewModel.calcHeight(containerWidth: bounds.width)
    }

    public func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let view = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? LyricsCell ?? LyricsCell()
        view.update(with: lyricsViewModels[row])
        return view
    }
}

extension LyricsView: NSTableViewDelegate {
    private func reloadViewModels() {
        scrollViewHadScrolledByUser = false
        lyricsViewModels.removeAll()

        guard let lyrics = lyrics?.emptyToNil() else {
            tableView.reloadData()
            return
        }

        parser = LyricsParser(lyrics: lyrics)

        for lyric in parser!.lyrics {
            let viewModel = LyricsCellViewModel.cellViewModel(lyric: lyric.text,
                                                              font: lyricFont,
                                                              highlightedFont: lyricHighlightedFont,
                                                              textColor: lyricTextColor,
                                                              highlightedTextColor: lyricHighlightedTextColor
            )
            lyricsViewModels.append(viewModel)
        }
        tableView.reloadData()
        enclosingScrollView?.contentInsets = NSEdgeInsets(top: frame.height / 2, left: 0, bottom: frame.height / 2, right: 0)
    }

    internal func scroll(toTime time: TimeInterval, animated: Bool) {
        guard !scrollViewHadScrolledByUser, let lyrics = parser?.lyrics else {
            return
        }

        guard let index = lyrics.index(where: { $0.time >= time }) else {
            // when no lyric is before the time passed in means scrolling to the first
            if (lyricsViewModels.count > 0) {
                tableView.scrollToBeginningOfDocument(nil)
            }
            return
        }

        guard lastIndex == nil || index - 1 != lastIndex else {
            return
        }

        if let lastIndex = lastIndex {
            lyricsViewModels[lastIndex].highlighted = false
        }

        if index > 0 {
            lyricsViewModels[index - 1].highlighted = true
            tableView.centreRow(row: index - 1, animated: true)
            lastIndex = index - 1
        }
    }
}

private extension LyricsView {
    @objc func scrollViewDidEndLiveScroll(notification: Notification) {
        scrollViewHadScrolledByUser = true
    }
}

private extension NSTableView {
    func centreRow(row: Int, animated: Bool) {
        selectRowIndexes(IndexSet.init(integer: row), byExtendingSelection: false)
        let rowRect = frameOfCell(atColumn: 0, row: row)
        if let scrollView = enclosingScrollView {
            let centredPoint = NSMakePoint(0.0, rowRect.origin.y + (rowRect.size.height / 2) - ((scrollView.frame.size.height) / 2))
            if animated {
                scrollView.contentView.animator().setBoundsOrigin(centredPoint)
            } else {
                scroll(centredPoint)
            }
        }
    }
}
