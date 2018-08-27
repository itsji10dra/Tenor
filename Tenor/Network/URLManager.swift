//
//  URLManager.swift
//  Tenor
//
//  Created by Jitendra on 27/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

struct URLManager {
    
    // MARK: - Public
    
    static func getURL(for resource: EndPoint, appending parameters: Parameters? = nil) -> URL? {
        
        let endPoint = resource.rawValue
        
        var urlComponents = URLComponents(string: Configuration.url + endPoint)
        
        let convertItems: ((Parameters) -> [URLQueryItem]) = { parameters in
            return parameters.map { return URLQueryItem(name: $0, value: $1) }
        }
        
        var queryItems: [URLQueryItem] = convertItems(parameters ?? [:])
        
        let authParameters = getAuthenticationParameters()
        queryItems.append(contentsOf: convertItems(authParameters))
        
        let limitParameters = getLimitingParameters()
        queryItems.append(contentsOf: convertItems(limitParameters))
        
        urlComponents?.queryItems = queryItems
        
        return urlComponents?.url
    }
    
    // MARK: - Private
    
    static private func getAuthenticationParameters() -> Parameters {
        return ["key"   : Configuration.key]
    }
    
    static private func getLimitingParameters() -> Parameters {
        return ["limit" : "\(Configuration.pageLimit)"]
    }
}
