//
//  WelcomeViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 17.04.23.
//

import Foundation
import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    lazy var welcomeStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        
        return view
    }()
    
    lazy var welcomeImageView: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "Intersect 1")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var welcomeLabel: UILabel = {
       let view = UILabel()
        view.text = "Welcome!"
        view.textAlignment = .center
        view.tintColor = .black
        view.font = .robotoBold(ofSize: 25)
        
        return view
    }()
    
    lazy var createAccountButton: UIButton = {
        let view = UIButton()
        view.setTitle("Create an account", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .customBlack
        view.layer.cornerRadius = 4
        view.snp.makeConstraints { make in
            make.height.equalTo(36)
        }

        return view
    }()
    
    lazy var haveAccountButton: UIButton = {
        let view = UIButton()
        view.setTitle("I already have an account", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 4
        view.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupStackView()
    }
    
    func setupStackView() {
        view.addSubview(welcomeStackView)
        welcomeStackView.addArrangedSubviews(welcomeImageView, welcomeLabel, createAccountButton, haveAccountButton)
        welcomeStackView.setCustomSpacing(40, after: welcomeImageView)
        welcomeStackView.setCustomSpacing(40, after: welcomeLabel)
        welcomeStackView.setCustomSpacing(10, after: createAccountButton)
        
        welcomeStackView.snp.makeConstraints {
            $0.centerY.equalTo(view.snp.centerY)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
        }
    }
    
}
