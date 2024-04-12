//
//  HomeScreen.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 28/03/24.
//

import SwiftUI
import NukeUI

struct LaunchesListScreen: View {
    static let ROUTE_NAME = "launches-list-screen"
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var router: Router
    @ObservedObject private var viewModel: LaunchesViewModel
    
    init(viewModel: LaunchesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            switch viewModel.launchStatus.currentStatus {
            case .Idle:
                loading()
            case .Success(data: let data):
                List(data) {launch in
                    card(launch)
                        .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .id(UUID())
            case .Failure(code: _, message: _, exception: _):
                error()
            case .Loading:
                loading()
            }
        }
        .navigationTitle("Launches")
        .task {
            await viewModel.getLaunches()
        }
    }
    
    private func loading() -> some View {
        VStack {
            ProgressView()
        }
    }
    
    private func error() -> some View {
        VStack {
            Text("Failed to retrieve launches")
        }
    }
    
    private func card(_ launch: Launch) -> some View {
        ZStack(alignment:.bottomLeading) {
            VStack {
                if let img = launch.links?.flickr?.original {
                    LazyImage(url: URL(string: img[0])) { state in
                        if let image = state.image {
                            image
                                .resizable()
                                .frame(height: 150)
                                .clipShape(.rect(topLeadingRadius: 25, bottomLeadingRadius: 25, bottomTrailingRadius: 25, topTrailingRadius: 25))
                        } else if state.error != nil {
                           EmptyView()// Indicates an error
                        } else {
                            ProgressView()
                                .frame(width: UIScreen.screenWidth - 32, height: 150, alignment: .center)
                        }
                    }
                }
            }
            .shadow(color: colorScheme == .dark ? .kNeutralBlacklishColor : .kNeutralBlacklishLightColor, radius: 6, y: 2)
            .padding(.bottom, 8)
            VStack(alignment: .leading) {
                Text(launch.rocket)
                    .fontWeight(.heavy)
                    .font(.system(size: 18))
                    .padding(.bottom, 2)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1)
                    .lineLimit(1)
                if let details = launch.details {
                    Text(details)
                        .fontWeight(.heavy)
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 20)
                        .lineLimit(1)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
    }
    
}

#Preview {
    LaunchesListScreen(viewModel: LaunchesViewModel(launchesRepository: LaunchesRepository(http: Http(baseUrl: Envs.BASE_URL))))
}
