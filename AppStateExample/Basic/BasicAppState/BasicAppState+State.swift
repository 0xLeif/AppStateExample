import AppState
import SwiftUI

extension Application {
    var username: State<String> {
        state(initial: "Leif")
    }

    var isShowingSheet: State<Bool> {
        state(initial: false)
    }
}
