# SpotlightLyrics

---

![SpotlightLyrics](resources/cover.png 'SpotlightLyrics')

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

- Download or clone the repository,
- Copy `SpotlightLyrics.framework` from frameworks folder to the your project,
- Open your project in XCode and navigate to `General` - `Linked Frameworks and Libraries` to add the component into you project

## Using

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

// Scroll to the TimeInterval you want to highlight
lyricsView.scroll(to: 20, animated: true)
```

I have uploaded a DEMO for the repository, check it at https://github.com/jayasme/SpotlightLyrics_Demo

## Contributing

I am welcoming anyone who wants to contribute with the repository, if you have any good idea or problem with the repository, please establish PR or issues.

## License

[MIT licensed](LICENSE).
