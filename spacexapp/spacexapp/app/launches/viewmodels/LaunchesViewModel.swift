//
//  LaunchesViewModel.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 08/04/24.
//

import Foundation

class LaunchesViewModel: ObservableObject {
    let launchesRepository: ILaunchesRepository
    
    @Published var launchStatus: PaginatedResultStatus<[Launch]> = PaginatedResultStatus(currentStatus: .Idle)
    
    init(launchesRepository: ILaunchesRepository) {
        self.launchesRepository = launchesRepository
    }
    
    @MainActor func getLaunches() async {
        launchStatus.currentStatus = .Loading
        
        let launchesResult = await launchesRepository.getLaunches(page: launchStatus.page, limit: launchStatus.limit)
        
        launchStatus.currentStatus = launchesResult
        
        if case .Success(let data) = launchesResult {
            launchStatus.data = data
        }
        
        launchStatus.page += 1
    }
}
