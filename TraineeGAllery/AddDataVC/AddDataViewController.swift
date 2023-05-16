//
//  AddDataViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit
import SnapKit

enum TextViews {
    
    case nameTextView(UITextView)
    case descriptionTextView(UITextView)
}

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
    
//    lazy var nameTextField: UITextField = {
//        let view = UITextField()
//        view.layer.cornerRadius = 4
//        view.layer.borderWidth = 1
//        view.layer.borderColor = .mainGrey
//        view.keyboardType = .default
//        let placeholderText = NSMutableAttributedString(string: "Name")
//        placeholderText.addAttribute(.font,
//                                    value: UIFont.robotoRegular(ofSize: 17),
//                                    range: NSRange(location: 0, length: placeholderText.length))
//        view.attributedPlaceholder = placeholderText
//        return view
//    }()
    lazy var nameTextField: UITextView = {
        let view = UITextView()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = .mainGrey
        view.keyboardType = .default
        let placeholderText = NSMutableAttributedString(string: "Name")
        placeholderText.addAttribute(.font,
                                    value: UIFont.robotoRegular(ofSize: 17),
                                    range: NSRange(location: 0, length: placeholderText.length))
//        view.attributedPlaceholder = placeholderText
        view.text = placeholderText.string
        return view
    }()
    
//    lazy var descriptionTextField: UITextField = {
//        let view = UITextField()
//        view.layer.cornerRadius = 4
//        view.layer.borderWidth = 1
//        view.layer.borderColor = .mainGrey
//        let placeholderText = NSMutableAttributedString(string: "Description")
//        placeholderText.addAttribute(.font,
//                                    value: UIFont.robotoRegular(ofSize: 17),
//                                    range: NSRange(location: 0, length: placeholderText.length))
//        view.attributedPlaceholder = placeholderText
//
//        return view
//    }()
    lazy var descriptionTextField: UITextView = {
        let view = UITextView()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = .mainGrey
//        let placeholderText = NSMutableAttributedString(string: "Description")
//        placeholderText.addAttribute(.font,
//                                    value: UIFont.robotoRegular(ofSize: 17),
//                                    range: NSRange(location: 0, length: placeholderText.length))
//        view.attributedPlaceholder = placeholderText
        view.textColor = .mainGrey
        view.font = .robotoRegular(ofSize: 17)
        view.keyboardType = .default
        view.text = "Description"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        navigationBar()
        nameTextField.delegate = self
        descriptionTextField.delegate = self
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

extension AddDataViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension AddDataViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ descriptionTextField: UITextView) {
        let view = TextViews.nameTextView(nameTextField)
        switch view {
        case .nameTextView(let uITextView):
            if descriptionTextField.text == "Description" {
                descriptionTextField.text = ""
                descriptionTextField.textColor = .customBlack
                descriptionTextField.font = .robotoRegular(ofSize: 17)
            }
        case .descriptionTextView(let uITextView):
            if descriptionTextField.text == "Description" {
                descriptionTextField.text = ""
                descriptionTextField.textColor = .customBlack
                descriptionTextField.font = .robotoRegular(ofSize: 17)
            }
        }
//        if descriptionTextField.text == "Description" {
//            descriptionTextField.text = ""
//            descriptionTextField.textColor = .customBlack
//            descriptionTextField.font = .robotoRegular(ofSize: 17)
//        }
    }
    
    func textViewDidEndEditing(_ descriptionTextField: UITextView) {
        if descriptionTextField.text.isEmpty {
            descriptionTextField.text = "Description"
            descriptionTextField.textColor = .mainGrey
            descriptionTextField.font = .robotoRegular(ofSize: 17)
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
