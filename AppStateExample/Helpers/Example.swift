import SwiftUI

protocol Example: View {
    var title: String { get }
    var description: String { get }
}

struct ExampleContainer<ExampleView: Example>: View {
    let example: ExampleView

    var body: some View {
        NavigationLink(
            destination: {
                example
                    .toolbar {
                        NavigationLink(
                            destination: {
                                ScrollView {
                                    VStack {
                                        Text(example.description)
                                    }
                                    .padding()
                                }
                                .navigationTitle("Info")
                            },
                            label: {
                                Image(systemName: "info.circle")
                            }
                        )
                    }
                    .navigationTitle(example.title)
            },
            label: {
                Text(example.title)
            }
        )
    }
}
