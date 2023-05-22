//
//  MainVC+SearchBar.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 19.05.23.
//

import Foundation
import UIKit

//MARK: - UICollectionViewDelegate
extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
       
//        if searchText.count >= 3 {
            let timer = Timer.scheduledTimer(withTimeInterval: 0.5,
                                             repeats: false) { [weak self] (_) in
                self?.presenter?.removeAlImages()

                self?.presenter?.getImagesForSearchBar(searchText: searchText)
            }
           
//        }
        
    }
}
