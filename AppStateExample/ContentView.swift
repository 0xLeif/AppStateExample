import AppState
import SwiftUI

fileprivate extension Application {
    var contentViewData: State<Bool> {
        state(initial: false)
    }
}

class ContentViewModel: ObservableObject {
    private let nameGenerator = Application.nameGenerator

    @AppState(\.isLoggedIn) var isLoggedIn: Bool
    @AppState(\.username) var username: String

    func updateName() {
        username = nameGenerator()
    }
}

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Text("Hello, \(viewModel.username)")

            Button("New") {
                viewModel.updateName()
            }
            
            Button("Log In", action: { viewModel.isLoggedIn = true })
        }
        .padding()
        .sheet(isPresented: $viewModel.isLoggedIn, content: InnerView.init)
    }
}

struct InnerView: View {
    @AppState(\.username) private var username: String
    
    var body: some View {
        Text("[\(username)]")
            .onTapGesture {
                username = "Tap"
            }
    }
}
