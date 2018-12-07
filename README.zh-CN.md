![SpotlightLyrics](resources/cover.png 'SpotlightLyrics')

---

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/SpotlightLyrics.svg)](https://cocoapods.org/pods/SpotlightLyrics)

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

- 下载或克隆本库并编译后取得`SpotlightLyrics.framework`。
- 将 `SpotlightLyrics.framework` 从 `frameworks` 文件夹复制到您的工程目录中
- 通过 XCode 打开您的项目并转到 `General` - `Linked Frameworks and Libraries` 来将控件添加到您的工程中。

## 如何使用

要引用 `SpotlightLyrics`，只需要像往常一样使用 `import` 语法中即可：

```Swift
import SpotlightLyrics
```

如果仅仅只是解析 LRC 文件，只需要使用到 `LyricsParser` 类，就像这样：

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

如果需要显示歌词控件在您的 View 或 Controller 中，则需要使用到 `LyricsView`，可按照如下方式使用：

```Swift
import SpotlightLyrics

... 从其它地方加载 LRC 歌词的字符串

let lyricsView = LyricsView()
lyricsView.frame = self.view.bounds
self.view.addSubView(lyricsView)

lyricsView.lyrics = lyricsString
lyricsView.font = UIFont.systemFont(ofSize: 13)
lyricsView.textColor = UIColor.black

// 滚动到需要高亮的时间
// 另外您需要自己维护另外一个线程或Timer来不断地调用这个函数，以便让歌词随着时间不断滚动。
lyricsView.scroll(toTime: 20, animated: true)
```

另外，您也查看[Demo](https://github.com/jayasme/SpotlightLyrics_Demo)

### 样式

`LyricsView` 支持下列属性来控制其样式。

| 属性名                    | 类型    | 默认值         | 说明             |
| ------------------------- | ------- | -------------- | ---------------- |
| lyricTextColor            | UIColor | LightGray      | 未高亮的歌词颜色 |
| lyricHighlightedTextColor | UIColor | Black          | 高亮的歌词颜色   |
| lyricFont                 | UIFont  | System 16      | 未高亮的歌词字体 |
| lyricHighlightedFont      | UIFont  | System 16 Bold | 高亮的歌词字体   |
| lineSpacing               | CGFloat | 16             | 歌词之间的行距   |

## Objective-C 兼容性

本库完全没有进行过任何 Objective-C 的测试。

## 参与项目

欢迎参与本项目，如果您任何有好的点子或遇到任何问题，请提交 PR 或 Issue，感谢您的支持。

## 许可

[MIT licensed](LICENSE).
