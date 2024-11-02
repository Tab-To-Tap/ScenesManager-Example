//
//  ToggleImmersiveSpaceButton.swift
//  ImmersiveScenesManager
//
//  Created by Tom Krikorian on 02/11/2024.
//

import SwiftUI
import ScenesManager

struct ToggleImmersiveSpaceButton: View {
    
    @Environment(\.scenesManager) private var scenesManager
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace

    var body: some View {
        Button {
            Task {
                await scenesManager.toggleImmersiveSpace()
            }
        } label: {
            Text(scenesManager.immersiveSpaceState == .open ? "Hide Immersive Space" : "Show Immersive Space")
        }
        .disabled(scenesManager.immersiveSpaceState == .inTransition)
        .animation(.none, value: 0)
        .fontWeight(.semibold)
    }
}
