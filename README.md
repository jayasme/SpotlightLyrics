![SpotlightLyrics](resources/cover.png 'SpotlightLyrics')

---

中文说明请点击[这里](README.zh-CN.md)

## Introducing

`SpotlightLyrics` is a open-source component which helps developers in parsing & displaying [LRC files](<https://en.wikipedia.org/wiki/LRC_(file_format)>), it was completely developed under [Swift](https://github.com/Apple/Swift) and designed for both iPhone and iPad platforms.

<figure class="half">

![Screenshot](resources/screenshot1.png 'Screenshot')
![Screenshot](resources/screenshot2.png 'Screenshot')

</figure>

## How to integrate

### Cocoapods

```
pod 'SpotlightLyrics'
```

### Manually

- Download or clone the repository and then compile it to obtain `SpotlightLyrics.framework`,
- Copy `SpotlightLyrics.framework` from frameworks folder to the your project,
- Open your project in XCode and navigate to `General` - `Linked Frameworks and Libraries` to add the component into you project

## How to use

To import the `SpotlightLyrics`, just import the `SpotlightLyrics` library in your code as usual.

```Swift
import SpotlightLyrics
```

To parse the LRC file only, just use `LyricsParser` class, do the following

```Swift
import SpotlightLyrics

... Load the lyrics string from local or remote

let parser = LyricsParser(lyrics: lyricsString)
print(parser.header.title)
print(parser.header.author)
print(parser.header.album)

print(parser.lyrics[0].lyrics)
print(parser.lyrics[0].time)
```

To display the lyrics in your view or controller, do the following

```Swift
import SpotlightLyrics

... Load the lyrics string from local or remote

let lyricsView = LyricsView()
lyricsView.frame = self.view.bounds
self.view.addSubView(lyricsView)

lyricsView.lyrics = lyricsString
lyricsView.font = UIFont.systemFont(ofSize: 13)
lyricsView.textColor = UIColor.black

// Scroll to the eplased time you want to highlight
// You need to call this function uninterruptedly with your own thread or timer so that make it scroll.
lyricsView.scroll(toTime: 20, animated: true)
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
