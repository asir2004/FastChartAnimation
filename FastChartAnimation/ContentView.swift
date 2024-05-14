//
//  ContentView.swift
//  FastChartAnimation
//
//  Created by Asir Bygud on 2024-05-14.
//

import SwiftUI

let demoDevices: [Device] = [
    Device(chip: "Apple M4", name: "iPad Pro 13 inch", score: 67, colors: [.green, .teal, .blue]),
    Device(chip: "Apple M3", name: "MacBook Air (M3)", score: 52, colors: [.blue, .purple]),
    Device(chip: "Apple M2", name: "iPad Air 11 inch", score: 49, colors: [.pink, .purple]),
    Device(chip: "Apple M1", name: "iPad Air 10.9 inch", score: 32),
    Device(chip: "Apple A17 Pro", name: "iPhone 15 Pro Max", score: 13),
]

struct ContentView: View {
    @AppStorage("chartTitle") var chartTitle: String = "GeekBench 6 Multicore Test"
    @AppStorage("chartSubtitle") var chartSubtitle: String = "Unit: Score"
    @AppStorage("chartFootnote") var chartFootnote: String = """
iPad 电量 50% 以上。
屏幕设定手动亮度，亮度 350 nits、音量 50%，机身初始温度为 31 °C。
20 分钟游戏初始画面最高画质静置测试。
"""
    @AppStorage("autoHighestScore") var autoHighestScore: Bool = true
    @AppStorage("frameWidth") var frameWidth: Double = 960
    
    @AppStorage("animationType") var animationType: String = "bouncy"
    @AppStorage("animationDuration") var animationDuration: Double = 0.7
    
    var devices: [Device] = []
    @State private var highestScore: Double = 0
    @State private var animationIsOver: Bool = false
    @State private var deviceScores: [Device: Double] = [:]
    @State private var deviceAnimations: [Device: Bool] = [:]
    
    @State private var isShowingSettingsView = false
    
    init(devices: [Device]) {
        self.devices = demoDevices
        
        for device in devices {
            self.deviceScores[device] = 0
            self.deviceAnimations[device] = false
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button("Toggle!") {
                    if animationIsOver {
                        // From 1 to 0 animation
                        Task {
                            animationIsOver = false
                            
                            for device in devices.reversed() {
                                // Progress bar animation
                                withAnimation(Animation.from(string: animationType, duration: animationDuration)) {
                                    deviceAnimations[device] = false
                                }
                                
                                // Text animation
                                withAnimation(Animation.from(string: animationType, duration: animationDuration)) {
                                    deviceScores[device] = 0
                                }
                                
                                try await Task.sleep(nanoseconds: 0_050_000_000)
                            }
                        }
                    } else {
                        // From 0 to 0 animation
                        Task {
                            animationIsOver = true
                            
                            for device in devices {
                                // Progress bar animation
                                withAnimation(Animation.from(string: animationType, duration: animationDuration)) {
                                    deviceAnimations[device] = true
                                }
                                
                                // Text animation
                                withAnimation(Animation.from(string: animationType, duration: animationDuration)) {
                                    deviceScores[device] = device.score
                                }
                                
                                try await Task.sleep(nanoseconds: 0_050_000_000)
                            }
                        }
                    }
                }
                
                Button("Settings") {
                    if !isShowingSettingsView {
                        isShowingSettingsView = true
                        
                        let newWindow = NSWindow(
                            contentRect: NSRect(x: 0, y: 0, width: 300, height: 400),
                            styleMask: [.titled, .closable, .resizable],
                            backing: .buffered, defer: true)
                        
                        newWindow.center()
                        newWindow.setFrameAutosaveName("Settings")
                        newWindow.contentView = NSHostingView(rootView: SettingsView(closeAction: {
                            isShowingSettingsView = false
                        }))
                        newWindow.makeKeyAndOrderFront(nil)
                        newWindow.isReleasedWhenClosed = false
                    }
                    
                    // TODO: Shift the focus to the Settings window when it's been created.
                }
            }
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(chartTitle)
                        .font(.title)
                        .bold()
                    
                    Text(chartSubtitle)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                    
                Text(chartFootnote)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                ForEach(devices) { device in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(device.chip)
                                .font(.title2)
                            
                            Text(device.name)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                        .frame(width: 90, alignment: .leading)
                        
                        Group {
                            Line()
                                .stroke(.linearGradient(colors: device.colors, startPoint: .leading, endPoint: .trailing), style: .init(lineWidth: 7, lineCap: .round, lineJoin: .round))
                                .frame(width: deviceAnimations[device] ?? false ? 700 / highestScore * device.score : 1)
                            
                            Text(verbatim: .init(deviceScores[device] ?? 0))
                                .font(.title)
                                .padding(.leading)
                                .contentTransition(.numericText())
                        }
                        .geometryGroup()
                    }
                    .padding(.trailing, 20)
                    .frame(height: 50)
                    .offset(y: deviceAnimations[device] ?? false ? 0 : 50)
                    .opacity(deviceAnimations[device] ?? false ? 1 : 0)
                }
            }
            
            Spacer()
        }
        .frame(width: 960, height: 540)
        .padding()
        .onAppear() {
            for device in devices {
                if device.score > highestScore {
                    self.highestScore = device.score
                }
            }
        }
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

#Preview {
    ContentView(devices: demoDevices)
}
