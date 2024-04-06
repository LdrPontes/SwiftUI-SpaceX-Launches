//
//  RocketDetailScreen.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 06/04/24.
//

import SwiftUI

struct RocketDetailScreen: View {
    static let ROUTE_NAME = "rocket-detail-screen"
    
    @EnvironmentObject var router: Router
    
    let title: String
    let count: Int
    
    var body: some View {
        VStack {
            Text(title)
            Button("More Detail") {
                router.pushNamed(RocketDetailScreen.ROUTE_NAME, args: ["Rocket Detail \(count)", count + 1])
            }
            if count == 5 {
                Button("Pop To Root") {
                    router.popToRoot()
                }
            }
        }.navigationTitle("Rocket Detail")
    }
}

#Preview {
    @State var path: NavigationPath = NavigationPath()
    return RouterView(path: $path) {
        RocketDetailScreen(title: "Rocket Detail", count: 0)
    }
}
