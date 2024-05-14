//
//  Device.swift
//  FastChartAnimation
//
//  Created by Asir Bygud on 2024-05-15.
//

import SwiftUI

struct Device: Identifiable, Hashable {
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
