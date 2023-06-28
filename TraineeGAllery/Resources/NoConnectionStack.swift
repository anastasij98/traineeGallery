//
//  NoConnectionScreen.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.04.23.
//

import Foundation
import UIKit

// TODO: 1) разделяем методы верстки / конфигурацию вьюхи ✅
// 2) выносим куда нибудь(экстеншен/новый файл) ✅

class NoConnectionStack: UIView {
    
    lazy var noConnectionStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        
        return view
    }()
    
    lazy var noConnectionImage: UIImageView = {
        let view = UIImageView()
        view.image = R.image.intersect()
        
        return view
    }()
    
    lazy var noConnectionTitle: UILabel = {
        let view = UILabel()
        view.font = R.font.robotoRegular(size: 17)
        view.textAlignment = .center
        view.textColor = .galleryGrey
        view.text = R.string.localization.noConnectionTitle()
        
        return view
    }()
    
    lazy var noConnectionDescription: UILabel = {
        let view = UILabel()
        view.font = R.font.robotoRegular(size: 12)
        view.textColor = .galleryGrey
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        view.text = R.string.localization.noConnectionDescription()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func addSubviews() {
        self.addSubview(noConnectionStackView)
        noConnectionStackView.addArrangedSubviews(noConnectionImage, noConnectionTitle, noConnectionDescription)
    }
    
    func configureLayout() {
        noConnectionStackView.snp.makeConstraints {
            $0.center.equalTo(self.snp.center)
        }
    }
}
