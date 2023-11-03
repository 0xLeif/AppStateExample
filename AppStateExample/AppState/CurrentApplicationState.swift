import AppState
import SwiftUI

struct CurrentApplicationState: View {
    @AppState(\.username) private var username
    @AppState(\.theme) private var theme

    var body: some View {
        Text("username: \(username)")
        Text("theme: \(theme)")
    }
}

#Preview {
    CurrentApplicationState()
}
