import AppState
import SwiftUI

class ImageProvider {
    func image(named: String) -> Image {
        Image(systemName: named)
    }
}

// Registered Dependencies use the `dependency` function and are static.
extension Application {
    var imageProvider: Dependency<ImageProvider> {
        dependency(ImageProvider())
    }
}

struct BasicAppDependency: Example {
    var title: String { "App Dependency" }

    var description: String { "This example demonstrates how AppState allows for dependency injection in your SwiftUI application. You'll see how AppState makes it easy to define, access, and manage dependencies in a decoupled and scalable way. This approach facilitates testing and makes your components more reusable and easier to maintain." }

    @State private var image: Image?
    
    // Dependency Injection
    @AppDependency(\.imageProvider) private var imageProvider: ImageProvider

    private var imageView: Image {
        (image ?? Image(systemName: "ellipsis"))
            .resizable()
    }

    var body: some View {
        imageView
            .aspectRatio(contentMode: .fit)
            .padding()
            .safeAreaInset(edge: .bottom) {
                Button("Load Image") {
                    image = imageProvider.image(named: "brain")
                }
            }
    }
}

#Preview {
    BasicAppDependency()
}
