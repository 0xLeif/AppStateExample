import AppState
import SwiftUI

struct AppStateExample: Example {
    var title: String { "@AppState" }

    var description: String {
        """
        This example focuses on AppState's @AppState property wrapper. This is a tool that simplifies state management and updates across your SwiftUI application.
        """
    }

    var body: some View {
        Form {
            Section("Introduction") {
                Text(
                    """
                    The @AppState property wrapper is a feature provided by AppState to make state handling more elegant and straightforward. It allows state properties to be observed and automatically triggers view updates when they are altered.
                    """
                )
            }

            Section("Usage") {
                Text(
                    """
                    For example, consider you have a State property 'username' that holds a user's name. You can use the @AppState property wrapper to observe and manage this state in your SwiftUI views.
                    """
                )

                Text(
                    #"""
                    struct UserNameView: View {

                        @AppState(\\.username) var username

                        var body: some View {
                            TextField("Username", text: $username)
                        }
                    }
                    """#
                )
            }

            Section("Source Code") {
                Text(
                    """
                    The @AppState property wrapper is implemented as a property wrapper struct in Swift. Here's a simple rundown of its implementation:
                    """
                )

                Text(
                    """
                    @propertyWrapper
                    struct AppState<Value>: DynamicProperty {

                        let keyPath: WritableKeyPath<Application, State<Value>>

                        init(_ keyPath: WritableKeyPath<Application, State<Value>>) {
                            self.keyPath = keyPath
                        }

                        var wrappedValue: Value {
                            get { Application.state(keyPath).value }
                            nonmutating set { Application.state(keyPath).value = newValue }
                        }

                        var projectedValue: Binding<Value> {
                            .init(get: { self.wrappedValue }, set: { self.wrappedValue = $0 })
                        }
                    }
                    """
                )
            }
        }
    }
}

#Preview {
    AppStateExample()
}
