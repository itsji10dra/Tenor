//
//  SearchVC.swift
//  Tenor
//
//  Created by Jitendra on 27/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchVC: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    // MARK: - Data
    
    private lazy var resultsArray: [GIF] = []
    
    private let cellIdentifier = "PreviewCell"
    
    private var dataRequest: DataRequest?
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Methods

    private func fetchResult(for keyword: String) {
        
        guard let url = URLManager.getURL(for: .search, appending: ["q": keyword]) else { return }
        
        dataRequest?.cancel()

        dataRequest = Alamofire.request(url).responseData { [weak self] response in
                
            switch response.result {
            case .success:
                
                guard let data = response.data else {
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Response<[GIF]>.self, from: data)
                    self?.resultsArray = response.results ?? []
                } catch {
                    print(error)
                }
                
                DispatchQueue.main.async {
                    self?.resultCollectionView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            resultsArray.removeAll(keepingCapacity: true)
            resultCollectionView.reloadData()
            return
        }
        
        fetchResult(for: searchText)
    }
}

extension SearchVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PreviewCell
        
        if let url = resultsArray[indexPath.row].media?.first?.mp4?.preview {
        
            cell?.thumbImageView.af_setImage(withURL: url,
                                             placeholderImage: #imageLiteral(resourceName: "placeholder"),
                                             imageTransition: .crossDissolve(0.1))
        } else {
            cell?.thumbImageView.image = nil
        }
        
        return cell ?? UICollectionViewCell()
    }
}

extension SearchVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
