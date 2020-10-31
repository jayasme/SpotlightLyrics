//
//  ViewController.swift
//  SpotlightLyricsMacExample
//
//  Created by Lyt on 9/28/20.
//

import Cocoa
import SpotlightLyrics

/// An example for usage of LyricsView
final class ViewController: NSViewController {
    
    private lazy var playButton = NSButton(title: "Play from beginning", target: self, action: #selector(playFromBeginning))
    
    private lazy var lyricsView: LyricsView = {
        let lyricsView = LyricsView()
        if let filepath = Bundle.main.path(forResource: "imagine.lrc", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                lyricsView.lyrics = contents
            } catch {
                assertionFailure("contents could not be loaded")
            }
        } else {
            assertionFailure("txt file not found")
        }
        return lyricsView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        lyricsView.timer.play()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        view.addSubview(lyricsView)
        lyricsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lyricsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lyricsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lyricsView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        view.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: lyricsView.bottomAnchor),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
        ])
    }
    
    @objc private func playFromBeginning() {
        lyricsView.timer.reset()
        lyricsView.timer.play()
    }

}

