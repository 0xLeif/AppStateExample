import AppState

extension Application {
    static var nameGenerator: () -> String {
        dependency({ "Some Name" })
    }
}
