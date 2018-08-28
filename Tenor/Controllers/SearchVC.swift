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
    
    internal lazy var resultsArray: [GIF] = []
    
    internal let cellIdentifier = "PreviewCell"
    
    internal let cellHeight: CGFloat = 250
    
    private let anonIdViewModel = AnonIdViewModel()

    private let searchViewModel = SearchViewModel()
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAnonymousId()
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

    private func fetchAnonymousId() {
        
        ActivityIndicator.startAnimating()

        anonIdViewModel.getAnonymousId { [weak self] success in
            
            ActivityIndicator.stopAnimating()
            
            if success {
                self?.fetchResult()
            } else {
                self?.showRetryAlert()
            }
        }
    }
    
    private func fetchResult(for keyword: String = "") {
    
        ActivityIndicator.startAnimating()
        
        searchViewModel.search(using: keyword) { [weak self] (data, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    // Do not show error alert if, request was cancelled.
                    guard (error as NSError).code != -999 else { return }
                    self?.showErrorAlert(with: error.localizedDescription)
                }
                else if let data = data {
                    self?.resultsArray = data
                    self?.resultCollectionView.reloadData()
                }
                
                ActivityIndicator.stopAnimating()
            }
        }
    }
    
    @objc
    func orientationDidChange() {
        resultCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func showRetryAlert() {
        
        let alertController = UIAlertController(title: "Error",
                                                message: "Unable to fetch anonymous id.",
                                                preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.fetchAnonymousId()
        }
        alertController.addAction(retryAction)
        
        let withoutAction = UIAlertAction(title: "Search without anonymous id.", style: .default) { [weak self] _ in
            self?.fetchResult()
        }
        alertController.addAction(withoutAction)

        present(alertController, animated: true, completion: nil)
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
