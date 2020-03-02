//
//  File.swift
//  
//
//  Created by Podul on 2020/2/26.
//

import Foundation


@dynamicMemberLookup
final public class Document {
    private let _doc: htmlDocPtr
    private var rootNode: Node? { Node(xmlDocGetRootElement(_doc)) }
    
    init?(_ doc: htmlDocPtr?) {
        guard let doc = doc else { return nil }
        _doc = doc
    }
    
    public init(path: String, encoding: String = "utf-8") {
        guard let doc = htmlReadFile(path.cString(using: .utf8), encoding.cString(using: .utf8), Int32(XML_PARSE_RECOVER.rawValue)) else {
            fatalError("read failed")
        }
        _doc = doc
    }
    
    public init(text: String, encoding: String = "utf-8") {
        let prt = text.cString(using: .utf8)!
        guard let doc = htmlReadMemory(prt, Int32(prt.count - 1), nil, encoding.cString(using: .utf8), Int32(XML_PARSE_RECOVER.rawValue | XML_PARSE_NOERROR.rawValue | XML_PARSE_NOWARNING.rawValue)) else {
            fatalError("read failed")
        }
        _doc = doc
    }
    
    deinit { xmlFreeDoc(_doc) }
    
    
    public subscript(dynamicMember tagString: String) -> XPath {
        XPath(doc: _doc, tagString: tagString)
    }
}

extension Document: CustomStringConvertible {
    public var description: String {
        return rootNode?.description ?? "nil"
    }
}
