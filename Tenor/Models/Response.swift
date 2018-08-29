//
//  Response.swift
//  Tenor
//
//  Created by Jitendra on 27/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

struct Response<T>: Decodable where T: Decodable {
    
    let webURL: URL?
    
    let results: T?
    
    let next: String?
    
    enum CodingKeys: String, CodingKey {
        case webURL = "weburl"
        case results
        case next
    }
}
