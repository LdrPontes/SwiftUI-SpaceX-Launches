//
//  LaunchRepository.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 08/04/24.
//

import Foundation

class LaunchesRepository: ILaunchesRepository {
    func getLaunches() async -> ResultStatus<[Launch]> {
        return .Idle
    }
}
