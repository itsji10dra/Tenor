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
    
    private let cellHeight: CGFloat = 250
    
    private var dataRequest: DataRequest?
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchResult()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SearchVC.orientationDidChange), name: Notification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Methods

    private func fetchResult(for keyword: String = "") {
        
        guard let url = URLManager.getURL(for: .search, appending: ["q": keyword]) else { return }
        
        dataRequest?.cancel()
        
        ActivityIndicator.startAnimating()
        
        dataRequest = Alamofire.request(url).responseData { [weak self] response in
            
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    ActivityIndicator.stopAnimating()
                    
                    guard let data = response.data else {
                        self?.showErrorAlert(with: "No data received.")
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(Response<[GIF]>.self, from: data)
                        self?.resultsArray = response.results ?? []
                    } catch {
                        self?.showErrorAlert(with: error.localizedDescription)
                    }
                    
                    self?.resultCollectionView.reloadData()
                    
                case .failure(let error):
                    // Do not show error alert if, request was cancelled.
                    guard (error as NSError).code != -999 else { return }
                    ActivityIndicator.stopAnimating()
                    self?.showErrorAlert(with: error.localizedDescription)
                }
            }
        }
    }
    
    @objc
    func orientationDidChange() {
        resultCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func showErrorAlert(with message: String) {
        
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okayAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension SearchVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
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
        }
        
        return cell ?? UICollectionViewCell()
    }
}

extension SearchVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let url = resultsArray[indexPath.row].media?.first?.mp4?.url else { return }

        let _ = VideoPlayer.playVideo(with: url)
    }
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch UIDevice.current.userInterfaceIdiom {
        case .carPlay, .tv, .unspecified:
            fallthrough
        case .phone:
            return CGSize(width: collectionView.frame.width, height: cellHeight)
        case .pad:
            return CGSize(width: collectionView.frame.width/2, height: cellHeight)
        }
    }
}

