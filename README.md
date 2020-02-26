# XParser
基于libxml2 的 html 解析

## Usage
1.创建`Document`
```swift
let doc = Document("path")
```
2.使用`XPath`语法进行查找
```swift
doc["//title"].node?.name
doc["//title"].node?.content
doc["//meta[@name='generator']"].node?.propertry("content")
doc["//div/div/h2/span[@id='Welcome_to_the_iPhone_Wiki']"].node?.content
```
不了解`XPath`的可以前往[w3school](https://www.w3school.com.cn/xpath/index.asp)学习了解.

## Requirements

* iOS 10.0+
* MacOS 10.12+
* Xcode 11.4+
* Swift 5.2+

## Swift Package Manager
``` Swift
.package(url: "https://github.com/podul/XParser", .branch("master"))
```

#### 注意
由于`Xcode 11.4`才支持`import libxml2`，所以`Xcode`最低支持版本为`11.4`。目前为`beta`版，需前往[开发者网站](https://developer.apple.com/)下载。

## Author

Podul, ylpodul@gmail.com

## License

PropertyDecoder is available under the MIT license. See the LICENSE file for more info.
