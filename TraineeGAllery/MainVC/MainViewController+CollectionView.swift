//
//  MainViewControllerExt.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 31.03.23.
//

import Foundation
import UIKit

//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(withIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let itemsCount = presenter?.getItemsCount() else { return }
        let lastItemIndex = itemsCount - 1
        if indexPath.item == lastItemIndex {
            presenter?.loadMore()
        }
    }
}
//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getItemsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.cellId, for: indexPath) as? MainCollectionViewCell,
              let item = presenter?.getItem(index: indexPath.item) else { return UICollectionViewCell() }
        
        let request = URLConfiguration.url + URLConfiguration.media + (item.image?.name ?? "")
        let model = CollectionViewCellModel(imageURL: URL(string: request))
        cell.setupCollectionItem(model: model)
        cell.backgroundColor = .mainGrey
        
        return cell
    }
}
//MARK: -  UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.current.orientation.isLandscape {
            let itemsInRow: CGFloat = 5
            let paddingsInRow: CGFloat = (itemsInRow - 1) * 9
            let allowedWidth = view.frame.width - paddingsInRow
            let itemsWidth = allowedWidth / itemsInRow
            return CGSize(width: itemsWidth, height: itemsWidth)
        } else {
            let itemsInRow: CGFloat = 2
            let sidePadding: CGFloat = 16
            let paddingsInRow: CGFloat = (itemsInRow - 1) * 9  + (sidePadding * 2)
            let allowedWidth = view.frame.width - paddingsInRow
            let itemsWidth = allowedWidth / itemsInRow
            return CGSize(width: itemsWidth, height: itemsWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter,
            presenter?.needIndicatorInFooter() ?? false {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Identifiers.indicatorReuseIdentifier, for: indexPath)
            footer.startRotating()
            return footer
        } else {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Identifiers.clearReuseIdentifier, for: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
       
        presenter?.needIndicatorInFooter() == true ? CGSize(width: 0, height: 50) : CGSize(width: 0, height: 0)
    }
}
