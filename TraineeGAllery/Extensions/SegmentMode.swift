//
//  SegmentedControl.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 28.03.23.
//

import Foundation
import UIKit

enum SegmentMode: CaseIterable {
    case new
    case popular
}


//enum SegmentMode: String, CaseIterable {
//    case new
//    case popular
//
//    init?(index: Int) {
//        if index == 0 {
//            self = .new
//        } else if index == 1 {
//            self = .popular
//        } else {
//            return nil
//        }
//    }
//}
//@objc
//func changeScreen(_ sender: UISegmentedControl) {
//    guard let newMode = SegmentMode(index: sender.selectedSegmentIndex) else {
//        return
//    }
//
//    mode = newMode
//let parametrs: Parameters = [
//    "page": "\(pageToLoad)",
//    "limit": "\(imagesPerPage)",
//    mode.rawValue: "true"
//]

//private var currentPageStorage: (new: Int, popular: Int) = (0, 0)
////    var currentNewPage = 0
////    var currentPopularPage = 0
//var currentPage: Int {
//    get {
//        switch mode {
//        case .new:
//            return currentPageStorage.new
//        case .popular:
//            return currentPageStorage.popular
//        }
//    }
//    set {
//        switch mode {
//        case .new:
//            currentPageStorage.new = newValue
//        case .popular:
//            currentPageStorage.popular = newValue
//        }
//    }
//}
