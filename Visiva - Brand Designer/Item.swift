//
//  Item.swift
//  Visiva - Brand Designer
//
//  Created by Visiva  - Brand Design Studio on 2026/01/04.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
