//
//  LaunchesViewModel.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 08/04/24.
//

import Foundation

class LaunchesViewModel: ObservableObject {
    @Published var launchStatus: PaginatedResultStatus<[Launch]> = PaginatedResultStatus(currentStatus: .Idle)
    
    func getLaunches() async {
        do {
            let http = Http(baseUrl: URL(string: "https://api.spacexdata.com/v5")!)
            
            let (data, request) = try await http.get("/launches")
            
            print(data)
            print(request?.statusCode ?? "200")
        } catch {
            print(error)
        }
        
    }
}
