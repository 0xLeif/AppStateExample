import AppState
import SwiftUI

struct ApplicationState: Example {
    var title: String { "State" }

    var description: String { "This example introduces AppState's State feature. These are mutable properties that, when altered, trigger a series of updates across UI elements dependent on this state." }

    var body: some View {
        Form {
            Section("Introduction") {
                Text(
                    """
                    AppState State properties are observables that communicate changes throughout the application, triggering UI updates wherever they are used. When the State properties are changed, any views that depend on them will be automatically and efficiently re-rendered by SwiftUI.
                    """
                )
            }

            Section("Usage") {
                Text(
                    """
                    Consider a simple AppState State property - 'username'. Here's how you define this State property in the Application:
                    """
                )

                Text(
                    #"""
                    extension Application {
                        var username: State<String> {
                            state(initial: "User")
                        }
                    }

                    // Access the value
                    var username: String = Application.state(\\.username).value

                    // Access the State
                    var username: Application.State<String> = Application.state(\\.username)
                    """#
                )
            }

            Section("Source Code") {
                Text(
                    """
                    AppState's State implementation is a struct that provides a way to manage and store state in the application. It elegantly handles state changes, triggering updates throughout the application when they occur. Below is an overview of AppState's State struct implementation:
                    """
                )

                Text(
                    """
                    public struct State<Value> {
                        /// A private backing storage for the value.
                        private var _value: Value

                        /// The current state value.
                        public var value: Value {
                            get {
                                guard
                                    let value = shared.cache.get(
                                        scope.key,
                                        as: Value.self
                                    )
                                else { return _value }

                                return value
                            }
                            set {
                                _value = newValue
                                shared.cache.set(
                                    value: newValue,
                                    forKey: scope.key
                                )
                            }
                        }

                        // ...
                    }
                    """
                )
            }
        }
    }
}

#Preview {
    ApplicationState()
}
