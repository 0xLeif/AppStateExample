//
//  AppStateExampleApp.swift
//  AppStateExample
//
//  Created by Leif on 11/1/23.
//

import AppState
import SwiftUI

extension Application {
    var userSettings: Dependency<UserSettings> {
        dependency(UserSettings())
    }
}

class CustomApplication: Application {
    override func didChangeExternally(notification: Notification) {
        super.didChangeExternally(notification: notification)

        DispatchQueue.main.async {
            Application.dependency(\.userSettings).objectWillChange.send()
        }
    }
}

@main
struct AppStateExampleApp: App {
    @ObservedObject private var userSettings = Application.dependency(\.userSettings)

    init() {
        Application.promote(to: CustomApplication.self)
            .logging(isEnabled: true)
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                Form {
                    Section("Basic Examples") {
                        ExampleContainer(example: BasicAppDependency())
                        ExampleContainer(example: BasicAppState())
                        ExampleContainer(example: BasicViewModelAppState())
                    }
                    Section("Advanced Examples") {
                        ExampleContainer(example: AdvancedAppDependency())
                    }
                    Section("AppState") {
                        ExampleContainer(example: AppStateDependency())
                        ExampleContainer(example: ApplicationState())
                        ExampleContainer(example: AppStateExample())
                    }
                    Section("Current Application State") {
                        CurrentApplicationState()
                    }
                }
                .navigationTitle("AppState")
                .toolbar {
                    Button(
                        action: {
                            userSettings.toggleTheme()
                        },
                        label: {
                            Image(systemName: userSettings.isLightMode ? "moon" : "sun.max")
                        }
                    )
                }
                .preferredColorScheme(userSettings.isLightMode ? .light : .dark)
            }
        }
    }
}
