//
//  MainVC+SearchBar.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 19.05.23.
//

import Foundation
import UIKit

//MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        presenter?.searchedText = searchText
//        if searchText.count >= 3 {
        presenter?.resetValues()
        presenter?.removeAllSearchedImages()
        presenter?.loadMoreSearched(searchText: searchText)
//        }
        updateView(restoreOffset: true)
    }
}
