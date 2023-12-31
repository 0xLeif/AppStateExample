import AppState
import SwiftUI

struct CurrentApplicationState: View {
    @AppState(\.username) private var username
    @SyncState(\.theme) private var theme

    var body: some View {
        Text("username: \(username)")
        Text("theme: \(theme)")
    }
}

#Preview {
    CurrentApplicationState()
}
