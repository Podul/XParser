//
//  utils.swift
//  
//
//  Created by Podul on 2020/2/26.
//

import Foundation
@_exported import libxml2.HTMLparser


extension String {
    var prt: [xmlChar]! {
        cString(using: .ascii)?.map { xmlChar($0) }
    }
}
