//
//  Media.swift
//  Tenor
//
//  Created by Jitendra on 27/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

struct Media: Decodable {
    
    let url: URL?
    
    let dimension: [Int]?
    
    let duration: Double?
    
    let preview: URL?
    
    let size: Int64?
    
    enum Keys: String, CodingKey {
        case url
        case dimension = "dims"
        case duration
        case preview
        case size
    }
}
