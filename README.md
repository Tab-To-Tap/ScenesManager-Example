# ScenesManager Example App

This is an example visionOS application demonstrating the usage of [ScenesManager](https://github.com/Tab-To-Tap/ScenesManager), a SwiftUI package for managing windows and immersive spaces in visionOS applications.

## Authors

Created by [Tom Krikorian](https://github.com/tomkrikorian) and [Tina Debove Nigro](https://github.com/tinanigro)

## Overview

This example app showcases:
- Window management with multiple scenes
- Immersive space integration
- Scene lifecycle tracking
- Event suppression handling

## Features

The app demonstrates several key features of ScenesManager:

1. **Multiple Window Management**
   - Main window with content view
   - Immersive menu window that appears during immersive experiences

2. **Immersive Space Control**
   - Toggle between normal and immersive modes
   - Smooth transitions between states
   - State tracking and management

3. **Scene Lifecycle Events**
   - Window opening/closing events
   - Immersive space state transitions
   - Event suppression demonstration

## Getting Started

### Prerequisites
- visionOS 2.0+
- Swift 5.9+

### Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/ScenesManager-Example.git
```

2. Open `ScenesManager-Example.xcodeproj` in Xcode

3. Build and run the project on your visionOS simulator or device

## Code Structure

The example app is organized into several key components:

### Main App Scene
Shows the basic setup of ScenesManager in a visionOS app:
```swift
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
    }
}
```

### Content Views
- `ContentView`: Main window interface with toggle button for immersive space
- `ImmersiveView`: Immersive space content with RealityKit integration
- `ImmersiveMenuView`: Controls displayed during immersive experiences

### Scene Identifiers
Custom scene identifiers are defined in:
```swift
public extension SceneId {
    static var mainWindow: Self { .init(rawValue: "MainWindow") }
    static var immersiveMenu: Self { .init(rawValue: "ImmersiveMenu") }
}
```

## Usage Examples

### Toggle Immersive Space
The app includes a button to toggle the immersive space:
```swift
struct ToggleImmersiveSpaceButton: View {
    @Environment(\.scenesManager) private var scenesManager
    
    var body: some View {
        Button {
            Task {
                await scenesManager.toggleImmersiveSpace()
            }
        } label: {
            Text(scenesManager.immersiveSpaceState == .open ? 
                 "Hide Immersive Space" : 
                 "Show Immersive Space")
        }
        .disabled(scenesManager.immersiveSpaceState == .inTransition)
    }
}
```

### Window Management
Example of window management in the immersive view:
```swift
struct ImmersiveMenuView: View {
    @Environment(\.scenesManager) private var scenesManager
    
    var body: some View {
        VStack {
            Text("Second Window!")
        }
        .padding()
        .sceneTracker(for: SceneId.immersiveMenu, onOpen: {
            print("Opened")
        }, onDismiss: {
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
```

## Learn More

For more information about the ScenesManager package, visit:
- [ScenesManager GitHub Repository](https://github.com/Tab-To-Tap/ScenesManager)
- [API Documentation](https://github.com/Tab-To-Tap/ScenesManager#readme)