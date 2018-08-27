//
//  Configuration.swift
//  Tenor
//
//  Created by Jitendra on 27/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

struct Configuration {
    
    static let url          = "https://api.tenor.com"
    
    static let key          = "5OG0LXMV7LV2"
    
    static let pageLimit    = 8

    static func checkConfiguration() {
        
        if url.isEmpty || key.isEmpty {
            fatalError("""
                Invalid configuration found
            """)
        }
    }
}
