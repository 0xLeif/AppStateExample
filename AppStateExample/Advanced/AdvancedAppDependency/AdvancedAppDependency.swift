import AppState
import SwiftUI

extension Application {
    var theme: SyncState<String> {
        syncState(initial: "Light", id: "theme")
    }
}

class UserSettings: ObservableObject {
    @AppState(\.username) var username: String
    @SyncState(\.theme) var theme: String

    var isDarkMode: Bool { theme == "Dark" }
    var isLightMode: Bool { theme == "Light" }

    func toggleTheme() {
        if isLightMode {
            theme = "Dark"
        } else {
            theme = "Light"
        }
    }
}

struct AdvancedAppDependency: Example {
    var title: String { "App Dependency" }

    var description: String { "Demonstrating AppState's flexibility, this example focuses on the use of an immutable ObservableObject, UserSettings, registered as a dependency. As you interact and switch between themes, observe how AppState manages and retains state changes in the immutable ObservableObject. If the ObservableObject was registered as App State, then the object itself would become mutable and could be reassigned. Making an object a dependency will guarentee it won't be reassigned." }

    @ObservedObject private var userSettings = Application.dependency(\.userSettings)

    var body: some View {
        VStack {
            Text("Hello, \(userSettings.username)!")


            Button("Switch Theme") {
                userSettings.toggleTheme()
            }
        }
        .preferredColorScheme(userSettings.isLightMode ? .light : .dark)
    }
}

#Preview {
    AdvancedAppDependency()
}
