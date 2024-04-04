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
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button("Back to List") {
                router.pop()
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.red)
        }
        .navigationTitle("Test")
    }
}

#Preview {
    LaunchDetailScreen()
}
