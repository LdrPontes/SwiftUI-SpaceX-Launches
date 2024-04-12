//
//  LaunchesRepository.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 08/04/24.
//

import Foundation

protocol ILaunchesRepository {
    func getLaunches(page: Int, limit: Int) async -> ResultStatus<[Launch]>
}
