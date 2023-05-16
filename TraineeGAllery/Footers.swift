//
//  Footer.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 31.03.23.
//

import Foundation
import UIKit

class IndicatorFooterView: UICollectionReusableView {
    
    let activity: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Ellipse")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage() {
        
        self.addSubview(activity)
        activity.snp.makeConstraints({
            $0.center.equalTo(self.snp.center)
        })
    }
}

class ClearFooterView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
