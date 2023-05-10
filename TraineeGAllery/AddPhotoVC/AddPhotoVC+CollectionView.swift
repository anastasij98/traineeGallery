//
//  AddPhotoVC+CollectionView.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit

extension AddPhotoViewController: UICollectionViewDelegate {
    
    
}

extension AddPhotoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let array = ["cat1", "cat2", "cat3", "cat4", "cat5", "cat6"]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
        cell.backgroundView = UIImageView(image: UIImage(named: array.randomElement()!))
        
        return cell
    }
    
}

extension AddPhotoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.current.orientation.isLandscape {
            let itemsInRow: CGFloat = 4
            let paddingsInRow: CGFloat = (itemsInRow - 1) * 9
            let allowedWidth = view.frame.width - paddingsInRow
            let itemsWidth = allowedWidth / itemsInRow
            return CGSize(width: itemsWidth, height: itemsWidth)
        } else {
            let itemsInRow: CGFloat = 4
            let sidePadding: CGFloat = 16
            let paddingsInRow: CGFloat = (itemsInRow - 1) * 9  + (sidePadding * 2)
            let allowedWidth = view.frame.width - paddingsInRow
            let itemsWidth = allowedWidth / itemsInRow
            return CGSize(width: itemsWidth, height: itemsWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
    }
}
