//
//  LaunchesRoutes.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 04/04/24.
//

import Foundation
import SwiftUI

let launchesRoutes: [String: Route] = [
    LaunchesListScreen.ROUTE_NAME: Route { args in LaunchesListScreen() },
    LaunchDetailScreen.ROUTE_NAME: Route { args in LaunchDetailScreen() },
]
