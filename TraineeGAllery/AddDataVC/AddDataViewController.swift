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
    
    var imageObject: Data?
    
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
        view.backgroundColor = .customLightGrey
        view.contentMode = .scaleAspectFit
        view.image = UIImage(data: imageObject ?? Data())

        return view
    }()
    
    lazy var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGrey
        
        return view
    }()

    lazy var nameTextView: UITextView = {
        let view = UITextView()
        view.setupTextView(text: "Name")
        
        return view
    }()
    
    lazy var descriptionTextView: UITextView = {
        let view = UITextView()
        view.setupTextView(text: "Description")
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        navigationBar()
        setupNavigationBar(image: UIImage(named: "Vector")!)
    }
    
    func setupViewController() {
        view.backgroundColor = .white
        scrollView.delegate = self
        nameTextView.delegate = self
        descriptionTextView.delegate = self

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(imageView, nameTextView, descriptionTextView)
        stackView.setCustomSpacing(10, after: imageView)
        stackView.setCustomSpacing(10, after: nameTextView)

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
        
        nameTextView.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
        }
        
        descriptionTextView.snp.makeConstraints {
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

extension AddDataViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.descriptionTextView.text == "Description" {
            textView.text = ""
            textView.textColor = .customBlack
            textView.font = .robotoRegular(ofSize: 17)
        }
        
        if self.nameTextView.text == "Name" {
            textView.text = ""
            textView.textColor = .customBlack
            textView.font = .robotoRegular(ofSize: 17)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.descriptionTextView.text.isEmpty {
            textView.text = "Description"
            textView.textColor = .mainGrey
            textView.font = .robotoRegular(ofSize: 17)
        }
        
        if self.nameTextView.text.isEmpty {
            textView.text = "Name"
            textView.textColor = .mainGrey
            textView.font = .robotoRegular(ofSize: 17)
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
