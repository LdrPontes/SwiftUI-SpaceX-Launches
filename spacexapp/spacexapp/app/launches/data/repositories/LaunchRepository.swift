//
//  LaunchRepository.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 08/04/24.
//

import Foundation

class LaunchesRepository: ILaunchesRepository {
    let http: Http
    
    init(http: Http) {
        self.http = http
    }
    
    func getLaunches(page: Int, limit: Int) async -> ResultStatus<[Launch]> {
        do {
            let (data, _) = try await http.get(Endpoints.getLaunches, queryParams: ["page": "\(page)", "limit": "\(limit)"])
            
            let launches: [Launch] = try! JSONDecoder().decode([Launch].self, from: data)
            
            return .Success(data: launches.filter {item in item.links?.flickr?.original != nil && (item.links?.flickr?.original?.count ?? 0) > 0})
        } catch {
            print(error)
            return .Failure(exception: error)
        }
    }
}
