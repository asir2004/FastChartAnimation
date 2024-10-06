//
//  LineShape.swift
//  FastChartAnimation
//
//  Created by Asir Bygud on 2024-05-17.
//

import SwiftUI

struct Line: Shape {
    // Here's a bug, this path can't recognize the frame width & height
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}
