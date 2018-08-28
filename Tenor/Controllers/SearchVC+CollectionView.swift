//
//  SearchVC+CollectionView.swift
//  Tenor
//
//  Created by Jitendra on 29/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

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
