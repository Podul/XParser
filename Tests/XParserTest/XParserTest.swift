//
//  File.swift
//  
//
//  Created by Podul on 2020/2/20.
//

import XCTest
import XParser

class ParserTest: XCTestCase {
    func testHTMLParser() {
        
        let path = URL(fileURLWithPath: #file).deletingLastPathComponent().path + "/Files/1.html"
        
        let doc = Document(path: path)
        
        XCTAssert(doc.title()?.name == "title")
        XCTAssert(doc.title()?.content == "The iPhone Wiki")
        XCTAssert(doc.meta["@name='generator'"]?.get("content") == "MediaWiki 1.31.6")
        XCTAssert(doc.meta["@name='generator'"]?.get("content") == doc.meta(custom: "[@name='generator']")?.get("content"))
        XCTAssert(doc.html.head.link(["rel": "search", "type": "application/opensearchdescription+xml"])?.get("title") == "The iPhone Wiki (en)")
        XCTAssert(doc.div.div.h2.span["@id='Welcome_to_the_iPhone_Wiki'"]?.content == "Welcome to the iPhone Wiki")
        
        XCTAssert(doc.html()?.attributes == ["class": "client-js", "lang": "en", "dir": "ltr"])
        XCTAssert(doc.html()?.children != nil)
        
        XCTAssert(doc.html.head()?.child?[4].get("href") == "/w/load.php?debug=false&lang=en&modules=mediawiki.legacy.commonPrint%2Cshared%7Cmediawiki.sectionAnchor%7Cmediawiki.skinning.interface%7Cskins.vector.styles&only=styles&skin=vector")
        
        guard let text = try? String(contentsOfFile: path) else { XCTFail(); return }
        XCTAssert(Document(text: text).description != "nil")
    }
}


