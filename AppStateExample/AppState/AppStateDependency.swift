import AppState
import SwiftUI

struct AppStateDependency: Example {
    var title: String { "Dependency" }

    var description: String { "This example demonstrates how AppState handles Dependencies. Dependencies in AppState are objects that are shared across the application, but unlike State, they are not observed and will not cause views to update when they change." }

    var body: some View {
        Form {
            Section("Introduction") {
                Text(
                    """
                    AppState supports dependencies - objects that are designed to be widely shared and used across several different parts of an application.

                    This makes it an excellent solution for services, utilities, and other shared resources. Unlike AppState, changes to these dependencies don't trigger view updates.
                    """
                )
            }

            Section("Usage") {
                Text(
                        """
                        For instance, consider you have a custom 'ImageProvider' class that fetches and caches images.

                        To use it as an AppState dependency, you extend 'Application' and provide a computed property that retrieves 'ImageProvider' as a dependency.

                        By calling 'Application.imageProvider', you'll get the shared instance of 'ImageProvider', or a new instance will get created and then stored if no existing one was found.
                        """
                    )
                Text(
                    #"""
                    class ImageProvider { ... }

                    extension Application {
                        var imageProvider: ImageProvider {
                            dependency(ImageProvider())
                        }
                    }

                    let imageProvider: ImageProvider = Application.dependency(\\.imageProvider)
                    """#
                )
            }

            Section("Source Code") {
                Text(
                    """
                    Here's the implementation of a Dependency in AppState:
                    """
                )
                Text(
                    """
                    func dependency<Value>(
                        _ object: @autoclosure () -> Value,
                        feature: String = "App",
                        id: String
                    ) -> Dependency<Value> {
                        let scope = Scope(name: feature, id: id)
                        let key = scope.key

                        guard let dependency = cache.get(key, as: Dependency<Value>.self) else {
                            let value = object()
                            let dependency = Dependency(
                                value,
                                scope: scope
                            )

                            cache.set(value: dependency, forKey: key)

                            return dependency
                        }

                        return dependency
                    }
                    """
                )
            }
        }
    }
}

#Preview {
    AppStateDependency()
}
