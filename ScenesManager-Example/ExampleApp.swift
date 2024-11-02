//
//  ExampleApp.swift
//  ExampleApp
//
//  Created by Tom Krikorian on 02/11/2024.
//

import SwiftUI
import ScenesManager

@main
struct ExampleApp: App {
    @Environment(\.openWindow) var openWindow   
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    @State private var scenesManager = ScenesManager()

    var body: some Scene {
        WindowGroup(id: SceneId.mainWindow.rawValue) {
            ContentView()
                .environment(\.scenesManager, scenesManager)
                .onAppear {
                    scenesManager.setActions(
                        openWindow: openWindow,
                        dismissWindow: dismissWindow,
                        openImmersiveSpace: openImmersiveSpace,
                        dismissImmersiveSpace: dismissImmersiveSpace
                    )
                }
        }
        
        WindowGroup(id: SceneId.immersiveMenu.rawValue) {
            ImmersiveMenuView()
                .environment(\.scenesManager, scenesManager)
        }

        ImmersiveSpace(id: SceneId.immersiveSpace.rawValue) {
            ImmersiveView()
                .environment(\.scenesManager, scenesManager)
        }
        .immersionStyle(selection: .constant(.full), in: .full)
    }
}
