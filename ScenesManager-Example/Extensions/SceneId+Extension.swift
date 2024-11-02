//
//  Scene+Extension.swift
//  ImmersiveScenesManager
//
//  Created by Tom Krikorian on 03/11/2024.
//
import ScenesManager

public extension SceneId {
    static var mainWindow: Self { .init(rawValue: "MainWindow") }
    static var immersiveMenu: Self { .init(rawValue: "ImmersiveMenu") }
}
