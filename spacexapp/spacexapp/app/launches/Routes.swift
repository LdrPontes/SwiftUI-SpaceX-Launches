//
//  Routes.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 03/04/24.
//

import Foundation
import SwiftUI

let launchesRoutes: [String: Route] = [
    LaunchesListScreen.ROUTE_NAME: { LaunchDetailScreen() },
    LaunchDetailScreen.ROUTE_NAME: { LaunchDetailScreen() },
]
