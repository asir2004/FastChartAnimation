//
//  FastChartAnimationApp.swift
//  FastChartAnimation
//
//  Created by Asir Bygud on 2024-05-14.
//

import SwiftUI
import SwiftUIViewRecorder

@main
struct FastChartAnimationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(devices: demoDevices, recordingViewModel: ViewRecordingSessionViewModel<URL>())
        }
    }
}
