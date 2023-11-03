import AppState
import SwiftUI

struct BasicAppState: Example {
    var title: String { "App State" }

    var description: String { "AppState is a property wrapper allowing SwiftUI views to subscribe to Application’s state changes in a reactive way. Works similar to State and Published." }

    @AppState(\.isShowingSheet) private var isShowingSheet: Bool
    @AppState(\.username) private var username: String

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Text("Hello, \(username)")

            Button("New") {
                username = "!!!"
            }

            Button("Log In", action: { isShowingSheet = true })
        }
        .sheet(isPresented: $isShowingSheet, content: BasicAppStateInnerView.init)
    }
}

struct BasicAppStateInnerView: View {
    @AppState(\.username) private var username: String

    var body: some View {
        Text("[\(username)]")
            .onTapGesture {
                username = "Tap"
            }
    }
}

#Preview {
    BasicAppState()
}
