//
//  HomeScreen.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 28/03/24.
//

import SwiftUI

struct LaunchesListScreen: View {
    @EnvironmentObject var router: Router
    
    static let ROUTE_NAME = "launches-list-screen"
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button("Detail") {
                router.pushNamed(LaunchDetailScreen.ROUTE_NAME)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.red)
        }
        .navigationTitle("Hello")
        .padding()
    }
    
}

#Preview {
    @State var path: NavigationPath = NavigationPath()
    return RouterView(path: $path) {
        LaunchesListScreen()
    }
}
