import AppState

struct ImageProvider { /* ... */ }

extension Application {
    static var nameGenerator: () -> String {
        dependency({ "Some Name" })
    }

    static var imageProvider: ImageProvider {
        dependency(ImageProvider())
    }
}

