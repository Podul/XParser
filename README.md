# XParser
基于libxml2 的 html 解析

## Usage
1. 创建`Document`
```swift
let doc = Document("path")
```
2. 查找，可使用`XPath`语法
```swift
// 标签名
doc.title()?.name

// 内容
doc.title()?.content
doc.div.div.h2.span["@id='Welcome_to_the_iPhone_Wiki'"]?.content

// 使用 XPath 方式
doc.meta(custom: "[@name='generator']")?.get("content")

// 获取属性
doc.meta[custom: "[@name='generator']"]?.get("content")
doc.meta["@name='generator'"]?.get("content")
doc.html.head.link(["rel": "search", "type": "application/opensearchdescription+xml"])?.get("title")

// 获取当前标签所有属性
doc.html()?.attributes

// 获取当前节点的所有子节点
doc.html()?.children

// 获取当前节点的4个兄弟节点
doc.html.head()?.child?[4]
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

XParser is available under the MIT license. See the LICENSE file for more info.
