# SpotlightLyrics

---

![SpotlightLyrics](resources/cover.png 'SpotlightLyrics')

For English descriptions, click [here](README.md)

## 介绍

`SpotlightLyrics`是一个开源的控件，主要用来解析并显示[LRC 歌词文件](<https://en.wikipedia.org/wiki/LRC_(file_format)>)，它完全使用[Swift](https://github.com/Apple/Swift)来开发并为 iPhone 和 iPad 平台而设计。

<figure class="half">

![Screenshot](resources/screenshot1.png 'Screenshot')
![Screenshot](resources/screenshot2.png 'Screenshot')

</figure>

## 如何集成

### 使用 Cocoapods

```
pod 'SpotlightLyrics'
```

### 手动集成

- 下载或克隆本库
- 将 `SpotlightLyrics.framework` 从 `frameworks` 文件夹复制到您的工程目录中
- 通过 XCode 打开您的项目并转到 `General` - `Linked Frameworks and Libraries` 来将控件添加到您的工程中。

## 使用方法

要引用 `SpotlightLyrics`，只需要像往常一样引用库到代码中即可：

```Swift
import SpotlightLyrics
```

如果只是要要解析 LRC 文件，只需要使用到 `LyricsParser` 类，就像这样：

```Swift
import SpotlightLyrics

... 从其它地方加载 LRC 歌词的字符串

let parser = LyricsParser(lyrics: lyricsString)
print(parser.header.title)
print(parser.header.author)
print(parser.header.album)

print(parser.lyrics[0].lyrics)
print(parser.lyrics[0].time)
```

如果需要显示歌词在您的 View 或 Controller 中，请按照如下方式：

```Swift
import SpotlightLyrics

... 从其它地方加载 LRC 歌词的字符串

let lyricsView = LyricsView()
lyricsView.frame = self.view.bounds
self.view.addSubView(lyricsView)

lyricsView.lyrics = lyricsString
lyricsView.font = UIFont.systemFont(ofSize: 13)
lyricsView.textColor = UIColor.black

// Scroll to the TimeInterval you want to highlight
lyricsView.scroll(to: 20, animated: true)
```

另外我上传了 Demo，请到 https://github.com/jayasme/SpotlightLyrics_Demo 查看。

## 参与项目

欢迎任何想要参与本库的朋友，如果你有任何好点子或问题，请提交 PR 和 Issue。

## 许可

[MIT licensed](LICENSE).
