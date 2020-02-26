//
//  File.swift
//  
//
//  Created by Podul on 2020/2/26.
//

import Foundation


final public class Document {
    private let _doc: htmlDocPtr
    
    init?(_ doc: htmlDocPtr?) {
        guard let doc = doc else { return nil }
        _doc = doc
    }
    
    public init(_ path: String) {
        guard let doc = htmlReadFile(path.cString(using: .utf8), "utf-8".cString(using: .utf8), Int32(XML_PARSE_RECOVER.rawValue)) else {
            fatalError("read failed")
        }
        _doc = doc
    }
    
    deinit { xmlFreeDoc(_doc) }
    
    public subscript(xPath: String) -> XPath {
        XPath(_doc: _doc, path: xPath)
    }
}
