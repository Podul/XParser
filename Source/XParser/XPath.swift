//
//  File.swift
//  
//
//  Created by Podul on 2020/2/26.
//

import Foundation


///
public struct XPath {
    let _doc: htmlDocPtr
    let path: String
    
    public var node: Node? {
        guard let context = xmlXPathNewContext(_doc) else { return nil }
        defer { xmlXPathFreeContext(context) }
        guard let result = xmlXPathEvalExpression(path.prt, context) else { return nil }
        defer { xmlXPathFreeObject(result) }
        
        guard result.pointee.type == XPATH_NODESET else { return nil }
        return Node(result.pointee.nodesetval?.pointee.nodeTab?.pointee)
    }
    
}
