//
//  ImmersiveMenuView.swift
//  ImmersiveScenesManager
//
//  Created by Tom Krikorian on 03/11/2024.
//

import SwiftUI
import RealityKit
import ScenesManager

struct ImmersiveMenuView: View {
    @Environment(\.scenesManager) private var scenesManager
    
    var body: some View {
        VStack {
            Text("Second Window!")
        }
        .padding()
        .sceneTracker(for: SceneId.immersiveMenu, onOpen: {
            // This will only appear the first time the immersiveMenu appears because we will suppress this event on the first dismiss.
            print("Opened")
        }, onDismiss:  {
            onDismiss()
        })
    }
    func onDismiss() {
        Task {
            await scenesManager.toggleImmersiveSpace()
            scenesManager.openWindow(SceneId.mainWindow)
            scenesManager.suppressEvents(.openEvent, for: SceneId.immersiveMenu)
        }
    }
}

#Preview(windowStyle: .automatic) {
    ImmersiveMenuView()
}
