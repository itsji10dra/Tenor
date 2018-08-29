//
//  AnonIdViewModel.swift
//  Tenor
//
//  Created by Jitendra on 29/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation
import Alamofire

class AnonIdViewModel {
    
    // MARK: - IBOutlets
    
    private var dataRequest: DataRequest?
    
    // MARK: - Public Methods
    
    public func getAnonymousId(_ completion: @escaping ((Bool) -> Void)) {
        
        guard let url = URLManager.getURL(for: .anonymousId) else { return }
        
        dataRequest?.cancel()
                
        dataRequest = Alamofire.request(url).responseJSON { response in
            
            switch response.result {
            case .success:
                
                guard let json = response.value as? [String: String],
                    let anonId = json["anon_id"] else {
                    return completion(false)
                }
                
                Configuration.anonymousId = anonId
                
                completion(true)
                
            case .failure( _):
                completion(false)
            }
        }
    }
}
