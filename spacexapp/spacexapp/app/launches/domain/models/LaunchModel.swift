//
//  LaunchModel.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 08/04/24.
//

import Foundation

struct Launch: Codable, Identifiable {
    let id: String
    let dateLocal: String
    let links: Links?
    let rocket: String
    let details: String?
    
    private enum CodingKeys : String, CodingKey {
            case id, dateLocal = "date_local", links, rocket, details
        }
    
    struct Links: Codable {
        var flickr: Flickr?
        
        struct Flickr: Codable {
            var original: [String]?
        }
    }
}
