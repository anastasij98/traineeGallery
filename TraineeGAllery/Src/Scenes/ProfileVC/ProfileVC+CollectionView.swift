//
//  ProfileVC+CollectionView.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 12.06.23.
//

import Foundation
import UIKit

//MARK: - UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectObject(withIndex: indexPath.item)
//        openAddView(index: indexPath.item)
    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//    }
}
//MARK: - UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getItemsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userImagesID, for: indexPath) as? MainCollectionViewCell,
              let item = presenter?.getItem(index: indexPath.item) else { return UICollectionViewCell() }
        let request = URLConfiguration.url + URLConfiguration.media + (item.image?.name ?? "")
        let model = CollectionViewCellModel(imageURL: URL(string: request))
        cell.setupCollectionItem(model: model)
        cell.backgroundColor = .galleryGrey
        
        return cell
    }
}
//MARK: -  UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let itemsInRow: CGFloat = 4
            let sidePadding: CGFloat = 16
            let paddingsInRow: CGFloat = (itemsInRow - 1) * 9  + (sidePadding * 2)
            let allowedWidth = view.frame.width - paddingsInRow
            let itemsWidth = allowedWidth / itemsInRow
        
            return CGSize(width: itemsWidth, height: itemsWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
    }
}
