//
//  File.swift
//  
//
//  Created by Podul on 2020/2/26.
//

import Foundation
import libxml2

/// 标签
public class Node {
    private let _node: xmlNodePtr
    
    private var childCount: UInt { xmlChildElementCount(_node) }

    init?(_ node: xmlNodePtr?) {
        var aNode = node
        while aNode?.pointee.type != XML_ELEMENT_NODE {
            // 只取元素节点
            aNode = aNode?.pointee.next
            if aNode == nil { break }
        }
        guard let node = aNode else { return nil }
        _node = node
    }
    
    public subscript(index: UInt) -> Self {
        var node = self
        for _ in 0..<index {
            guard let next = node.next as? Self else { break }
            node = next
        }
        return node
    }
}

extension Node {
    
    /// 上一个
    public var prev: Node? { Node(_node.pointee.prev) }
    /// 下一个
    public var next: Node? { Node(_node.pointee.next) }
    /// 父元素
    public var parent: Node? { Node(_node.pointee.parent) }
    /// 子元素
    public var child: Node? { Node(_node.pointee.children) }
    /// 最后一个
//    public var last: Node? { Node(xmlGetLastChild(_node)) }
    
    
    var doc: Document { Document(_node.pointee.doc)! }
    /// 所有属性
    public var attributes: [String: String] {
        var curProp = _node.pointee.properties
        var dict = [String: String]()
        
        while let name = curProp?.pointee.name {
            guard let value = _get(name) else { break }
            dict[String(cString: name)] = value
            curProp = curProp?.pointee.next
        }
        return dict
    }
    
    /// 所有子结点
    public var children: [Node] {
        var child: Node? = self.child
        var children: [Node] = child == nil ? [] : [child!]
        while let aChild = child?.next {
            children.append(aChild)
            child = child?.next
        }
        return children
    }
    
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
    public func get(_ attributeName: String) -> String? {
        _get(attributeName.prt)
    }
    
    private func _get(_ name: UnsafePointer<xmlChar>) -> String? {
        guard let cProp = xmlGetProp(_node, name) else { return nil }
        return String(cString: cProp)
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        guard let buffer = xmlBufferCreate() else { return "nil" }
        if xmlNodeDump(buffer, _node.pointee.doc, _node, 0, 1) == -1 {
            return "nil"
        }
        return String(cString: buffer.pointee.content)
    }
}
