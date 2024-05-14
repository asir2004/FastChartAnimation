//
//  SettingsView.swift
//  FastChartAnimation
//
//  Created by Asir Bygud on 2024-05-15.
//

import SwiftUI

struct SettingsView: View {
    var closeAction: () -> Void
    
    @AppStorage("chartTitle") var chartTitle: String = "GeekBench 6 Multicore Test"
    @AppStorage("chartSubtitle") var chartSubtitle: String = "Unit: Score"
    @AppStorage("chartFootnote") var chartFootnote: String = """
iPad 电量 50% 以上。
屏幕设定手动亮度，亮度 350 nits、音量 50%，机身初始温度为 31 °C。
20 分钟游戏初始画面最高画质静置测试。
"""
    
    @AppStorage("autoHighestScore") var autoHighestScore: Bool = true
    @AppStorage("frameWidth") var frameWidth: Double = 960
    @State private var frameWidthInput: String = "0"
    
    @AppStorage("animationType") var animationType: String = "bouncy"
    @AppStorage("animationDuration") var animationDuration: Double = 0.7
    
    var body: some View {
        NavigationStack {
            List {
                Section("Title Bar") {
                    HStack {
                        Image(systemName: "character.cursor.ibeam")
                        TextField("Title", text: $chartTitle)
                    }
                    
                    HStack {
                        Image(systemName: "character.cursor.ibeam")
                        TextField("Subtitle", text: $chartSubtitle)
                    }
                    
                    HStack(alignment: .top, spacing: 0) {
                        Image(systemName: "character.textbox")
                        TextEditor(text: $chartFootnote)
                    }
                }
                
                Section("Frame") {
                    HStack {
                        Label("Frame Width", systemImage: "arrow.left.and.right")
                            .foregroundStyle(.primary)
                        
                        Spacer()
                        
                        TextField("Frame Width", text: $frameWidthInput)
                            .onChange(of: frameWidthInput) {
                                frameWidth = Double(frameWidthInput) ?? 0
                            }
                            .onAppear() {
                                frameWidthInput = String(frameWidth.formatted())
                            }
                    }
                }
                
                Section("Animation") {
                    Picker(selection: $animationType, content: {
                        ForEach(Array(animationTypes.sorted(by: <)), id: \.key) { key, value in
                            Text("\(key)")
                                .tag(value)
                        }
                    }, label: {
                        Label("Animation Type", systemImage: "diamond.inset.filled")
                            .foregroundStyle(.primary)
                    })
                    
                    HStack {
                        Label("Animation Duration: \(animationDuration.formatted())", systemImage: "hourglass")
                            .foregroundStyle(.primary)
                        
                        Spacer()
                        
                        Stepper("Animation Duration", value: $animationDuration, in: 0...5, step: 0.1)
                            .labelsHidden()
                    }
                }
            }
        }
        .frame(width: 300, height: 400)
    }
}

let animationTypes: [String: String] = ["Default": "default", "Ease In": "easeIn", "Ease Out": "easeOut", "Ease In Out": "easeInOut", "Linear": "linear", "Bouncy": "bouncy", "Snappy": "snappy", "Spring": "spring"]

extension Animation {
    var stringValue: String {
        switch self {
        case .default:
            return "default"
        case .easeIn:
            return "easeIn"
        case .easeOut:
            return "easeOut"
        case .easeInOut:
            return "easeInOut"
        case .linear:
            return "linear"
        case .bouncy:
            return "bouncy"
        case .snappy:
            return "snappy"
        case .spring:
            return "spring"
        default:
            return "default" // 默认值
        }
    }
    
    static func from(string: String, duration: Double) -> Animation {
        switch string {
        case "default":
            return .default
        case "easeIn":
            return .easeIn(duration: duration)
        case "easeOut":
            return .easeOut(duration: duration)
        case "easeInOut":
            return .easeInOut(duration: duration)
        case "linear":
            return .linear(duration: duration)
        case "bouncy":
            return .bouncy(duration: duration)
        case "snappy":
            return .snappy(duration: duration)
        case "spring":
            return .spring(duration: duration)
        default:
            return .default // 默认值
        }
    }
}

#Preview {
    SettingsView(closeAction: { })
}
