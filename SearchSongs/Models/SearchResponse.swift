//
//  SearchResponse.swift
//  SearchSongs
//
//  Created by Алексей Каземиров on 3/22/22.
//

import Foundation
import UIKit

struct SearchResponse: Decodable {
    
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String?
    var collectionName: String?
    var artistName: String
    var artworkUrl60: String?
}
