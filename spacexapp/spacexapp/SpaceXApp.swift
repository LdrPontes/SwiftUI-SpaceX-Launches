//
//  spacexappApp.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 28/03/24.
//

import SwiftUI

@main
struct SpaceXApp: App {
    @State private var path: NavigationPath = NavigationPath()
    
    var body: some Scene {
        WindowGroup {
            RouterView(path: $path) {
                LaunchesListScreen()
            }
        }
    }
}
