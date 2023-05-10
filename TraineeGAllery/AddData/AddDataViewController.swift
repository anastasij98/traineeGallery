//
//  AddDataViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit
import SnapKit

class AddDataViewController: UIViewController, UIScrollViewDelegate {
    
    lazy var scrollView: UIScrollView = {
        var view = UIScrollView()
        view = UIScrollView(frame: .zero)
        view.isScrollEnabled = true
        view.scrollsToTop = false
        
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cat2")
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .customLightGrey
        
        return view
    }()
    
    lazy var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGrey
        
        return view
    }()
    
    lazy var nameTextField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = .mainGrey
        let placeholderText = NSMutableAttributedString(string: "Name")
        placeholderText.addAttribute(.font,
                                    value: UIFont.robotoRegular(ofSize: 17),
                                    range: NSRange(location: 0, length: placeholderText.length))
        view.attributedPlaceholder = placeholderText
        return view
    }()
    
    lazy var descriptionTextField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = .mainGrey
        let placeholderText = NSMutableAttributedString(string: "Description")
        placeholderText.addAttribute(.font,
                                    value: UIFont.robotoRegular(ofSize: 17),
                                    range: NSRange(location: 0, length: placeholderText.length))
        view.attributedPlaceholder = placeholderText
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        navigationBar()
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        scrollView.delegate = self

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(imageView, nameTextField, descriptionTextField)
        stackView.setCustomSpacing(10, after: imageView)
        stackView.setCustomSpacing(10, after: nameTextField)

        imageView.addSubview(underLine)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }

        stackView.snp.makeConstraints {
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(view.snp.width)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
        
        underLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalTo(imageView.snp.width)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
        
        nameTextField.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
        }
        
        descriptionTextField.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
        }
    }
    
    func navigationBar() {
        let rightButton = UIBarButtonItem(title: "Add",
                                          style: .plain,
                                          target: self,
                                          action: #selector(addData))
        rightButton.setTitleTextAttributes([.font : UIFont.robotoBold(ofSize: 15),
                                            .foregroundColor : UIColor.customPink],
                                           for: .normal)
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc
    func addData() {
        print("added")
    }
}
