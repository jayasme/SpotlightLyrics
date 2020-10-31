![SpotlightLyrics](resources/cover.png 'SpotlightLyrics')

---

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/SpotlightLyrics.svg)](https://cocoapods.org/pods/SpotlightLyrics)

中文说明请点击[这里](README.zh-CN.md)

## Introducing

`SpotlightLyrics` is an open-source library which helps developers in parsing & displaying [LRC files](<https://en.wikipedia.org/wiki/LRC_(file_format)>), it is completely developed under [Swift](https://github.com/Apple/Swift) 4.2 and designed for iOS and macOS.

<figure class="half">

![Screenshot](resources/screenshot1.png 'Screenshot')
![Screenshot](resources/screenshot2.png 'Screenshot')

</figure>

## Getting Started

### Cocoapods

```
pod 'SpotlightLyrics'
```

Use `pod 'SpotlightLyrics/Mac'` or `pod 'SpotlightLyrics/Mac'` to only pull in the subspec for a specific platform.

### Manually

- Download or clone the repository and then compile it to obtain `SpotlightLyrics.framework`,
- Copy `SpotlightLyrics.framework` from frameworks folder to the your project,
- Open your project in Xcode and navigate to `General` - `Linked Frameworks and Libraries` to add the component into you project

## How To Use

To start using `SpotlightLyrics` in your files, just do the following:

```Swift
import SpotlightLyrics
```

### LyricaParser

If you only parse LRC files, you can use the class `LyricsParser`, here's an example for it:

```Swift
import SpotlightLyrics

// ... Load the LRC string from local or remote

// Pass your lyrics string to create an instance
let parser = LyricsParser(lyrics: lyricsString)

// Now you get everything about the lyrics
print(parser.header.title)
print(parser.header.author)
print(parser.header.album)

for lyric in parser.lyrics {
  print(lyric.text)
  print(lyric.time)
}
```

### LyricsView

`SpotlightLyrics` provids an LRC displaying component for showing lyrics and scrolling like most of the music apps do:

```Swift
import SpotlightLyrics

// ... Load the LRC string from local or remote

// Create an instance and add it to your UI
let lyricsView = LyricsView()
lyricsView.frame = self.view.bounds
self.view.addSubView(lyricsView)

// Pass the LRC string and style the LyricsView
lyricsView.lyrics = lyricsString
lyricsView.font = UIFont.systemFont(ofSize: 13)
lyricsView.textColor = UIColor.black
lyricsView.highlightedFont = UIFont.systemFont(ofSize: 13)
lyricsView.highlightedTextColor = UIColor.lightGray

// Play
lyricsView.timer.play()

// Pause
lyricsView.timer.pause()

// Seek to an eplased time
lyricsView.timer.seek(toTime: 20.0)

// Start it over
lyricsView.timer.seek(toTime: 0)
lyricsView.timer.play()
```

Also, please check the [Demo](https://github.com/jayasme/SpotlightLyrics_Demo)

### Stylish

`LyricsView` supports the following properties to allow you to make it up.

| Property Name             | Type    | Default Value  | Description                              |
| ------------------------- | ------- | -------------- | ---------------------------------------- |
| lyricTextColor            | UIColor | LightGray      | The color of the unhighlighted lyrics    |
| lyricHighlightedTextColor | UIColor | Black          | The color of the highlighted lyrics      |
| lyricFont                 | UIFont  | System 16      | The font of the unhighlighted lyrics     |
| lyricHighlightedFont      | UIFont  | System 16 Bold | The font color of the highlighted lyrics |
| lineSpacing               | CGFloat | 16             | The spacing of each lyric lines          |

## Objective-C compatibility

This respository hasn't been tested under Objective-C environment in any way.

## Contributing

Any contribution is welcomed, please post PR or report issue if you have any good idea or encounter any problem. Thank you!

## License

[MIT licensed](LICENSE).
