//
//  Device.swift
//  FastChartAnimation
//
//  Created by Asir Bygud on 2024-05-15.
//

import SwiftUI
import SwiftData

//@Model
//class Device {
//    var chip: String
//    var name: String
//    var score: Double
//    var colors: [Color]
//    
//    init(chip: String, name: String, score: Double, colors: [Color] = [.white]) {
//        self.chip = chip
//        self.name = name
//        self.score = score
//        self.colors = colors
//    }
//}

struct Device: Hashable, Identifiable {
    var id: UUID
    var chip: String
    var name: String
    var score: Double
    var colors: [Color]
    
    init(chip: String, name: String, score: Double, colors: [Color] = [.white]) {
        self.id = UUID()
        self.chip = chip
        self.name = name
        self.score = score
        self.colors = colors
    }
}

let demoDevices: [Device] = [
    Device(chip: "Apple M4", name: "iPad Pro 13 inch", score: 67, colors: [.green, .teal, .blue]),
    Device(chip: "Apple M3", name: "MacBook Air (M3)", score: 52, colors: [.blue, .purple]),
    Device(chip: "Apple M2", name: "iPad Air 11 inch", score: 49, colors: [.pink, .purple]),
    Device(chip: "Apple M1", name: "iPad Air 10.9 inch", score: 32, colors: [.white]),
    Device(chip: "Apple A17 Pro", name: "iPhone 15 Pro Max", score: 13, colors: [.white]),
]
