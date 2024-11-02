//
//  ImmersiveView.swift
//  ImmersiveScenesManager
//
//  Created by Tom Krikorian on 02/11/2024.
//

import SwiftUI
import RealityKit
import ScenesManager

struct ImmersiveView: View {
    @Environment(\.scenesManager) private var scenesManager

    var body: some View {
        RealityView { content in
        }
        .sceneTracker(for: SceneId.immersiveSpace, onOpen: {
            onOpen()
        })
        .immersiveSpaceTracker()
    }
    
    func onOpen() {
        scenesManager.dismissWindow(.mainWindow)
        scenesManager.openWindow(.immersiveMenu)
    }
}

#Preview(immersionStyle: .full) {
    ImmersiveView()
}
