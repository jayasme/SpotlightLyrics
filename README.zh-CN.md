![SpotlightLyrics](resources/cover.png 'SpotlightLyrics')

---

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/SpotlightLyrics.svg)](https://cocoapods.org/pods/SpotlightLyrics)

For English descriptions, click [here](README.md)

## 介绍

`SpotlightLyrics`是一个开源库，主要用来解析并显示[LRC 歌词文件](<https://en.wikipedia.org/wiki/LRC_(file_format)>)，它完全使用[Swift](https://github.com/Apple/Swift)来开发并支持iOS和macOS。

<figure class="half">

![Screenshot](resources/screenshot1.png 'Screenshot')
![Screenshot](resources/screenshot2.png 'Screenshot')

</figure>

## 集成

### 使用 Cocoapods

```
pod 'SpotlightLyrics'
```
也可用`pod 'SpotlightLyrics/Mac'` 或 `pod 'SpotlightLyrics/Mac'`来只导入所需的平台代码。

### 手动集成

- 下载或克隆本库并编译后取得`SpotlightLyrics.framework`。
- 将 `SpotlightLyrics.framework` 从 `frameworks` 文件夹复制到您的工程目录中
- 通过 XCode 打开您的项目并转到 `General` - `Linked Frameworks and Libraries` 来将控件添加到您的工程中。

## 使用

To start using `SpotlightLyrics` in your files, just do the following:

要在您的文件中使用 `SpotlightLyrics`，只需要引用如下包即可：

```Swift
import SpotlightLyrics
```

### LyricaParser

如果您仅仅只需要解析 LRC 文件，那么就只需要使用到 `LyricsParser` 类，请参考下面的例子：

```Swift
import SpotlightLyrics

// ... 从其它地方加载 LRC 歌词的字符串

// 将歌词字符串传入构造函数来构建一个实例
let parser = LyricsParser(lyrics: lyricsString)

// 现在你已经拿到了所有你需要的东西
print(parser.header.title)
print(parser.header.author)
print(parser.header.album)

for lyric in parser.lyrics {
  print(lyric.text)
  print(lyric.time)
}
```

### LyricsView

`SpotlightLyrics` 还为您提供了一个用来带滚动功能的 LRC 文件的显示控件，就像其他大多数音乐 App 那样：

```Swift
import SpotlightLyrics

// ... 从其它地方加载 LRC 歌词的字符串

// 创建一个实例并将它添加到您的UI中
let lyricsView = LyricsView()
lyricsView.frame = self.view.bounds
self.view.addSubView(lyricsView)

// 传入LRC字符串并设置显示样式
lyricsView.lyrics = lyricsString
lyricsView.font = UIFont.systemFont(ofSize: 13)
lyricsView.textColor = UIColor.black
lyricsView.highlightedFont = UIFont.systemFont(ofSize: 13)
lyricsView.highlightedTextColor = UIColor.lightGray

// 播放
lyricsView.timer.play()

// 暂停
lyricsView.timer.pause()

// 跳转到指定的时间
lyricsView.timer.seek(toTime: 20.0)

// 重新播放
lyricsView.timer.seek(toTime: 0)
lyricsView.timer.play()
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
