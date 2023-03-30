//
//  SegmentedControl.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 28.03.23.
//

import Foundation
import UIKit

enum SegmentMode: String, CaseIterable {
    case new
    case popular
    
    init?(index: Int) {
        if index == 0 {
            self = .new
        } else if index == 1 {
            self = .popular
        } else {
            return nil
        }
    }
}
