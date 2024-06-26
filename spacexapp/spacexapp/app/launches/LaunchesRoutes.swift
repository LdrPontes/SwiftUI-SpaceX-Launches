//
//  LaunchesRoutes.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 04/04/24.
//

import Foundation
import SwiftUI

let launchesRoutes: [String: Route] = [
    LaunchesListScreen.ROUTE_NAME: Route { args in
        LaunchesListScreen(viewModel: LaunchesViewModel(launchesRepository: LaunchesRepository(http: Http(baseUrl: Envs.BASE_URL))))
    }
]
