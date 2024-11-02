//
//  ContentView.swift
//  ImmersiveScenesManager
//
//  Created by Tom Krikorian on 02/11/2024.
//

import SwiftUI
import RealityKit
import ScenesManager

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Main Window!")
            ToggleImmersiveSpaceButton()
        }
        .padding()
        .sceneTracker(for: SceneId.mainWindow)
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
