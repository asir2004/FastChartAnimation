//
//  AnimatedChartView.swift
//  FastChartAnimation
//
//  Created by Asir Bygud on 2024-05-17.
//

import SwiftUI

struct AnimatedChartView: View {
    @Binding var animationIsOver: Bool
    var devices: [Device]
    
    @AppStorage("chartTitle") var chartTitle: String = "GeekBench 6 Multicore Test"
    @AppStorage("chartSubtitle") var chartSubtitle: String = "Unit: Score"
    @AppStorage("chartFootnote") var chartFootnote: String = """
iPad 电量 50% 以上。
屏幕设定手动亮度，亮度 350 nits、音量 50%，机身初始温度为 31 °C。
20 分钟游戏初始画面最高画质静置测试。
"""
    @AppStorage("autoHighestScore") var autoHighestScore: Bool = true
    @AppStorage("frameWidth") var frameWidth: Double = 960
    @AppStorage("frameHeight") var frameHeight: Double = 540
    
    @AppStorage("animationType") var animationType: String = "bouncy"
    @AppStorage("animationDuration") var animationDuration: Double = 0.7
    
    @State private var highestScore: Double = 0
    @State private var deviceScores: [Device: Double] = [:]
    @State private var deviceAnimations: [Device: Bool] = [:]
    
    var body: some View {
        VStack {
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
        }
        .frame(width: frameWidth, height: frameHeight)
        .padding()
        .onAppear() {
            for device in devices {
                if device.score > highestScore {
                    self.highestScore = device.score
                }
            }
        }
        .onChange(of: animationIsOver) {
            if !animationIsOver {
                // From 1 to 0 animation
                Task {
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
                // From 0 to 1 animation
                Task {
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
    }
}

#Preview {
    AnimatedChartView(animationIsOver: .constant(true), devices: demoDevices)
}
