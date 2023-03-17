//
//  DemoSummary.swift
//  ARFun
//
//  Created by e on 3/16/23.
//

import Foundation


struct DemoSummary: Hashable, Identifiable {
    var id: String = UUID().uuidString
    var icon: String
    var description: String
    var type: DemoType
    
    init(icon: String, description: String, type: DemoType) {
        self.icon = icon
        self.description = description
        self.type = type
    }
}

enum DemoType {
    case selfies
    case AR
}
