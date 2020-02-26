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
//        /Users/podul/Documents/Modules/Swift/Parser/Tests/Files/1.html
        
        let path = URL(fileURLWithPath: #file).deletingLastPathComponent().path
        
        let doc = Document(path + "/Files/1.html")
        
        XCTAssert(doc["//title"].node?.name == "title")
        XCTAssert(doc["//title"].node?.content == "The iPhone Wiki")
        XCTAssert(doc["//meta[@name='generator']"].node?.propertry("content") == "MediaWiki 1.31.6")
        XCTAssert(doc["//link[last()]"].node?.propertry("title") == "The iPhone Wiki Atom feed")
        XCTAssert(doc["//div/div/h2/span[@id='Welcome_to_the_iPhone_Wiki']"].node?.content == "Welcome to the iPhone Wiki")
    }
}


