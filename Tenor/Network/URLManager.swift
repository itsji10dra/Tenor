//
//  URLManager.swift
//  Tenor
//
//  Created by Jitendra on 27/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

struct URLManager {
    
    // MARK: - Private Closures

    static private let convertItems: ((Parameters) -> [URLQueryItem]) = { parameters in
        return parameters.map { return URLQueryItem(name: $0, value: $1) }
    }

    // MARK: - Public Methods
    
    static public func getURL(for resource: EndPoint,
                              appending parameters: Parameters? = nil,
                              withLimit: Bool = false) -> URL? {
        
        let endPoint = resource.rawValue
        
        var urlComponents = URLComponents(string: Configuration.url + endPoint)
        
        //Query
        var queryItems: [URLQueryItem] = convertItems(parameters ?? [:])
        
        //Auth
        let authParameters = getAuthenticationParameters()
        queryItems.append(contentsOf: convertItems(authParameters))
        
        //Limit
        if withLimit {
            let limitParameters = getLimitingParameters()
            queryItems.append(contentsOf: convertItems(limitParameters))
        }
        
        //Anonymous
        if let anonParameters = getAnonymousIdParameters() {
            queryItems.append(contentsOf: convertItems(anonParameters))
        }
        
        urlComponents?.queryItems = queryItems
        
        return urlComponents?.url
    }
    
    // MARK: - Private Methods
    
    static private func getAuthenticationParameters() -> Parameters {
        return ["key"   : Configuration.key]
    }
    
    static private func getAnonymousIdParameters() -> Parameters? {
        guard let anonymoudId = UserDefaults.standard.string(forKey: kAnonymousIdKey) else { return nil }
        return ["anon_id"   : anonymoudId]
    }

    static private func getLimitingParameters() -> Parameters {
        return ["limit" : "\(Configuration.pageLimit)"]
    }
}
