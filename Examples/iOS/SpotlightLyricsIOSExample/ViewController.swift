//
//  ViewController.swift
//  SpotlightLyricsIOSExample
//
//  Created by Lyt on 9/28/20.
//

import UIKit
import SpotlightLyrics

final class ViewController: UIViewController {
    
    private lazy var playButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Play from beginning", for: .normal)
        button.addTarget(self, action: #selector(onPlayFromBeginningButtonTapped), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lyricsView.timer.play()
    }
    
    private func setupLayout() {
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
            playButton.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor, constant: -8)
        ])
    }
    
    @objc private func onPlayFromBeginningButtonTapped() {
        lyricsView.timer.reset()
        lyricsView.timer.play()
    }
    
}

