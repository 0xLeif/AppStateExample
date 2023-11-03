import AppState
import SwiftUI

struct BasicViewModelAppState: Example {
    class ViewModel: ObservableObject {
        @AppState(\.isShowingSheet) var isShowingSheet: Bool
        @AppState(\.username) var username: String

        func updateName() {
            username = "!!!"
        }
    }

    var title: String { "App State ViewModel" }

    var description: String { "This example shows how AppState can cooperate with a ViewModel to neatly organize your app's state logic. Using a ViewModel can further abstract the state management logic away from your views, leading to cleaner, more manageable code. You'll see how ViewModel and AppState can work together to provide a robust solution to state management in SwiftUI." }

    @ObservedObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Text("Hello, \(viewModel.username)")

            Button("New") {
                viewModel.updateName()
            }

            Button("Log In", action: { viewModel.isShowingSheet = true })
        }
        .sheet(isPresented: $viewModel.isShowingSheet) {
            BasicViewModelAppStateInnerView(username: $viewModel.username)
        }
    }
}

struct BasicViewModelAppStateInnerView: View {
    @Binding var username: String

    var body: some View {
        Text("[\(username)]")
            .onTapGesture {
                username = "Tap"
            }
    }
}

#Preview {
    BasicViewModelAppState()
}
