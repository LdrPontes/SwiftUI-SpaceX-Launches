//
//  LauchDetailScreen.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 01/04/24.
//

import SwiftUI

struct LaunchDetailScreen: View {
    static let ROUTE_NAME = "launch-detail-screen"
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Text("Hello World")
            Button("Back to List") {
                router.pop()
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.red)
            Button("New Screen") {
                router.pushNamed(RocketDetailScreen.ROUTE_NAME, args: ["First Rocket Detail", 0])
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.green)
        }
        .navigationTitle("Detail")
    }
}

#Preview {
    @State var path: NavigationPath = NavigationPath()
    return RouterView(path: $path) {
        LaunchDetailScreen()
    }
}
