//
//  SearchViewModel.swift
//  Tenor
//
//  Created by Jitendra on 29/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation
import Alamofire

class SearchViewModel {
    
    // MARK: - Alias
    
    typealias SearchResult = ((_ data: [GIF]?, _ error: Error?) -> Void)

    // MARK: - IBOutlets

    private var dataRequest: DataRequest?
    
    // MARK: - Public Methods

    public func search(using query: String, completion: @escaping SearchResult) {
        
        guard let url = URLManager.getURL(for: .search, appending: ["q": query], withLimit: true) else { return }
        
        dataRequest?.cancel()
        
        dataRequest = Alamofire.request(url).responseData { response in
            
            switch response.result {
            case .success:                
                guard let data = response.data else {
                    let error = NSError(domain: "No data received.", code: -1, userInfo: nil)
                    completion(nil, error)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Response<[GIF]>.self, from: data)
                    completion(response.results ?? [], nil)
                } catch {
                    completion(nil, error)
                }
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
