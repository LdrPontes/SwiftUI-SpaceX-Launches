//
//  LaunchModel.swift
//  spacexapp
//
//  Created by Leandro Pontes Berleze on 08/04/24.
//

import Foundation

struct Launch: Codable {
    let id: String
    let dateLocal: Date
    let links: Links?
    let rocket: String
    let details: String
    
    struct Links: Codable {
        var flickr: Flickr?
        
        struct Flickr: Codable {
            var original: [String]?
        }
    }
}
