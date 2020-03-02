//
//  File.swift
//  
//
//  Created by Podul on 2020/2/26.
//

import Foundation



@dynamicMemberLookup
public class XPath {
    private let _doc: htmlDocPtr
    private var tagString: String
    private var attributes: String = ""
    
    private var path: String {
        "//" + tagString + attributes
    }
    
    init(doc: htmlDocPtr, tagString: String) {
        _doc = doc
        self.tagString = tagString
    }
    
    public subscript(dynamicMember path: String) -> Self {
        tagString += "/" + path
        return self
    }
    
}

extension XPath {
    fileprivate var node: Node? {
        guard let context = xmlXPathNewContext(_doc) else { return nil }
        defer { xmlXPathFreeContext(context) }
        guard let result = xmlXPathEvalExpression(path.prt, context) else { return nil }
        defer { xmlXPathFreeObject(result) }
        
        guard result.pointee.type == XPATH_NODESET else { return nil }
        return Node(result.pointee.nodesetval?.pointee.nodeTab?.pointee)
    }
    
    public subscript(attributes: String) -> Node? {
        if attributes.hasPrefix("[") && attributes.hasSuffix("]") {
            self.attributes = "\(attributes)"
        }else {
            self.attributes = "[\(attributes)]"
        }
        return node
    }
    
    public func callAsFunction() -> Node? { node }
     
    public func callAsFunction(_ attributes: [String: String]) -> Node? {
        for (key, value) in attributes {
            if !self.attributes.isEmpty {
                self.attributes.append(" and ")
            }
            self.attributes.append("@\(key)")
            self.attributes.append("='\(value)'")
        }
        self.attributes = "[\(self.attributes)]"
        return node
    }
    
    public func callAsFunction(custom attributes: String) -> Node? {
        self.attributes = attributes
        return node
    }
     
}


extension XPath: CustomStringConvertible {
    public var description: String {
        return node?.description ?? "nil"
    }
}
