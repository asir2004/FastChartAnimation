//
//  ContentView.swift
//  FastChartAnimation
//
//  Created by Asir Bygud on 2024-05-14.
//

import SwiftUI
import SwiftUIViewRecorder

struct ContentView: View {
    @AppStorage("animationType") var animationType: String = "bouncy"
    @AppStorage("animationDuration") var animationDuration: Double = 0.7
    
    @AppStorage("frameWidth") var frameWidth: Double = 960
    @AppStorage("frameHeight") var frameHeight: Double = 540
    
    var devices: [Device] = []
    @State private var animationIsOver: Bool = false
    
    @State private var isShowingSettingsView = false
    
//    @ObservedObject var recordingViewModel: ViewRecordingSessionViewModel<URL>
    
//    init(devices: [Device]) {
//        self.devices = demoDevices
//        
//        for device in devices {
//            self.deviceScores[device] = 0
//            self.deviceAnimations[device] = false
//        }
//    }
    
//    init(devices: [Device], recordingViewModel: ViewRecordingSessionViewModel<URL>) {
//        self.devices = devices
//        self.recordingViewModel = recordingViewModel
//    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Button("Toggle!") {
                        animationIsOver.toggle()
                    }
                    
                    //                Button("Settings") {
                    //                    if !isShowingSettingsView {
                    //                        isShowingSettingsView = true
                    //
                    //                        let newWindow = NSWindow(
                    //                            contentRect: NSRect(x: 0, y: 0, width: 300, height: 400),
                    //                            styleMask: [.titled, .closable, .resizable],
                    //                            backing: .buffered, defer: true)
                    //
                    //                        newWindow.center()
                    //                        newWindow.setFrameAutosaveName("Settings")
                    //                        newWindow.contentView = NSHostingView(rootView: SettingsView(closeAction: {
                    //                            isShowingSettingsView = false
                    //                        }))
                    //                        newWindow.makeKeyAndOrderFront(nil)
                    //                        newWindow.isReleasedWhenClosed = false
                    //                    }
                    //
                    //                    // TODO: Shift the focus to the Settings window when it's been created.
                    //                }
                    
                    NavigationLink("Settings") {
                        SettingsView(closeAction: { })
                    }
                    
                    //                Button("Record") {
                    //                    recordingViewModel.handleRecording(session: try! AnimatedChartView.recordVideo())
                    //                }
                    //
                    //                Button("End") {
                    //                    guard let asset = recordingViewModel.asset else {
                    //                        print("No recorded asset found")
                    //                        return
                    //                    }
                    //
                    //                    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    //                    let outputURL = documentsDirectory.appendingPathComponent("exportedVideo.mov")
                    //
                    //                    exportAsset(from: asset, to: asset)
                    //                }
                    
                    //                ZStack {
                    //                    if (recordingViewModel.asset != nil) {
                    //                        Text("Video URL \(recordingViewModel.asset!)")
                    //                    } else {
                    //                        Text("Recording video...")
                    //                    }
                    //                }
                }
                
                AnimatedChartView(animationIsOver: $animationIsOver, devices: demoDevices)
                    .frame(width: frameWidth, height: frameHeight)
                
                Spacer()
            }
        }
    }
    
    
    
//    private func exportAsset(from inputURL: URL, to: URL) {
//        guard let exportSession = AVAssetExportSession(asset: AVAsset(url: inputURL), presetName: AVAssetExportPresetHighestQuality) else {
//            print("Failed to create export session")
//            return
//        }
//        
//        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let outputURL = documentsDirectory.appendingPathComponent("output.mov")
//
//        exportSession.outputURL = outputURL
//        exportSession.outputFileType = .mov
//        exportSession.exportAsynchronously {
//            switch exportSession.status {
//            case .completed:
//                print("Export completed: \(outputURL)")
//            case .failed:
//                if let error = exportSession.error {
//                    print("Export failed: \(error.localizedDescription)")
//                }
//            case .cancelled:
//                print("Export cancelled")
//            default:
//                break
//            }
//        }
//    }
}

#Preview {
    ContentView()
}
