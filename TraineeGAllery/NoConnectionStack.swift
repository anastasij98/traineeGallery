//
//  NoConnectionScreen.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.04.23.
//

import Foundation
import UIKit

class NoConnectionStack: UIView {
    
    var noConnectionStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        
        return view
    }()
    
    
    var noConnectionImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Intersect")
        
        return view
    }()
    
    var noConnectionTitle: UILabel = {
        let view = UILabel()
        view.font = .robotoRegular(ofSize: 17)
        view.textAlignment = .center
        view.textColor = .customGrey
        view.text = "Sorry!"
        
        return view
    }()
    
    var noConnectionDescription: UILabel = {
        let view = UILabel()
        view.font = .robotoRegular(ofSize: 12)
        view.textColor = .customGrey
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        view.text = "There is no pictures.\nPlease come back later."
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setupStackView() {
        self.addSubview(noConnectionStackView)
        noConnectionStackView.addArrangedSubviews(noConnectionImage, noConnectionTitle, noConnectionDescription)
        
        noConnectionStackView.snp.makeConstraints {
            $0.center.equalTo(self.snp.center)
        }
    }
}
