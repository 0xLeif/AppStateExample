import AppState

extension Application {
    var username: State<String> {
        state(initial: "Leif")
    }

    var isLoggedIn: State<Bool> {
        state(initial: false)
    }
}
