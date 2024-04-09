//
//  HomeScreen.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 28/03/24.
//

import SwiftUI

struct LaunchesListScreen: View {
    static let ROUTE_NAME = "launches-list-screen"
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var router: Router
    
    @StateObject private var viewModel: LaunchesViewModel = LaunchesViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                card()
                card()
                card()
                card()
                card()
                card()
            }.padding()
            
        }
        .navigationTitle("Launches")
        .onAppear {
            Task {
                await viewModel.getLaunches()
            }
       
        }
    }
    
    private func card() -> some View {
        ZStack(alignment:.bottomLeading) {
            VStack {
                AsyncImage(url: URL(string: "https://live.staticflickr.com/65535/49635401403_96f9c322dc_o.jpg")) { image in
                    image
                        .resizable()
                        .frame(height: 150)
                        .clipShape(.rect(topLeadingRadius: 25, bottomLeadingRadius: 25, bottomTrailingRadius: 25, topTrailingRadius: 25))
                } placeholder: {
                    ProgressView()
                        .frame(width: UIScreen.screenWidth - 32, height: 150, alignment: .center)
                        
                }
            }
            .shadow(color: colorScheme == .dark ? .kNeutralBlacklishColor : .kNeutralBlacklishLightColor, radius: 6, y: 2)
            .padding(.bottom, 8)
            VStack(alignment: .leading) {
                Text("Falcon 9")
                    .fontWeight(.heavy)
                    .font(.system(size: 18))
                    .padding(.bottom, 2)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1)
                Text("05-12-23")
                    .fontWeight(.heavy)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 20)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
    }
    
}

#Preview {
    @State var path: NavigationPath = NavigationPath()
    return RouterView(path: $path) {
        LaunchesListScreen()
    }
}
