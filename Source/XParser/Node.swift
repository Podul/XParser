//
//  File.swift
//  
//
//  Created by Podul on 2020/2/26.
//

import Foundation

/// 标签
final public class Node {
    private let _node: xmlNodePtr
    
    var children: Node? { Node(_node.pointee.children) }
    var last: Node? { Node(_node.pointee.last) }
    var parent: Node? { Node(_node.pointee.parent) }
    var next: Node? { Node(_node.pointee.next) }
    var prev: Node? { Node(_node.pointee.prev) }
    var doc: Document { Document(_node.pointee.doc)! }
    var childCount: UInt { xmlChildElementCount(_node) }
    
    init?(_ node: xmlNodePtr?) {
        guard let node = node else { return nil }
        _node = node
    }
}

extension Node {
    /// 标签名
    public var name: String? {
        guard let cName = _node.pointee.name else { return nil }
        return String(cString: cName)
    }
    
    /// 内容
    public var content: String? {
        guard let cContent = xmlNodeGetContent(_node) else { return nil }
        return String(cString: cContent)
    }
    
    /// 属性
    public func propertry(_ name: String) -> String? {
        guard let cProp = xmlGetProp(_node, name.prt) else { return nil }
        return String(cString: cProp)
    }
}
