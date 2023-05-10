//
//  DetailedVC.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.03.23.
//

import Foundation
import UIKit
import SnapKit

protocol DetailedViewControllerProtocol: AnyObject {
    
    func setupView(name: String,
                   user: String,
                   description: String,
                   date: String,
                   viewsCount: String)
    func setImage(data: Data)
}

class DetailedViewController: UIViewController, UIScrollViewDelegate {
    
    var presenter: DetailedPresenterProtocol?
    
    var scrollView: UIScrollView = {
        var view = UIScrollView()
        view = UIScrollView(frame: .zero)
        view.isScrollEnabled = true
        view.scrollsToTop = false

        return view
    }()
    
    var totalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        
        return view
    }()
    
    var upperStackView: UIStackView = {
        var view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        
        return view
    }()

    var lowerStackView: UIStackView = {
        var view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill

        return view
    }()
    
    var selectedImage: UIImageView = {
        var view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .mainGrey

        return view
    }()
    
    var imageTitle: UILabel = {
        var view = UILabel()
        view.textColor = .black
        view.font = .robotoRegular(ofSize: 20)
        view.numberOfLines = 0
        
        return view
    }()
    
    var usersLabel: UILabel = {
        var view = UILabel()
        view.textColor = .mainGrey
        view.font = .robotoRegular(ofSize: 15)
        view.textAlignment = .left
        
        return view
    }()
    
    var imageDescription: UILabel = {
        var view = UILabel()
        view.textColor = .black
        view.font = .robotoLight(ofSize: 15)
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 0
        view.textAlignment = .justified
        
        return view
    }()
    
    var viewsCount: UILabel = {
        var view = UILabel()
        view.textColor = .mainGrey
        view.font = .robotoRegular(ofSize: 12)
        view.textAlignment = .right
        view.numberOfLines = 0
        
        return view
    }()
    
    var eyeImage: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(systemName: "eye")?.withTintColor(.mainGrey,
                                                               renderingMode: .alwaysOriginal)

        return view
    }()
    
    var downloadDate: UILabel = {
        var view = UILabel()
        view.textColor = .mainGrey
        view.font = .robotoRegular(ofSize: 12)
        view.textAlignment = .right
        view.numberOfLines = 0
        
        return view
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
        presenter?.viewIsReady()
    }
  
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         
         view.backgroundColor = .white
    }
    
   func setupScrollView() {
       scrollView.delegate = self
       
       view.addSubview(scrollView)
       scrollView.addSubviews(totalStackView)
       upperStackView.addArrangedSubviews(imageTitle, viewsCount, eyeImage)
       lowerStackView.addArrangedSubviews(usersLabel, downloadDate)
       totalStackView.addArrangedSubviews(selectedImage, upperStackView, lowerStackView, imageDescription)
       
       totalStackView.setCustomSpacing(11.0, after: selectedImage)
       totalStackView.setCustomSpacing(10.0, after: upperStackView)
       totalStackView.setCustomSpacing(20.0, after: lowerStackView)

       scrollView.snp.makeConstraints {
           $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
       }
       
       totalStackView.snp.makeConstraints {
           $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading).offset(20)
           $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
           $0.top.equalTo(scrollView.contentLayoutGuide.snp.top)
           $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
       }
       
       selectedImage.snp.makeConstraints {
            $0.height.equalTo(251)
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
        }
       
       upperStackView.snp.makeConstraints {
           $0.leading.equalTo(totalStackView.snp.leading)
           $0.trailing.equalTo(totalStackView.snp.trailing)
       }
       
       imageDescription.snp.makeConstraints {
           $0.leading.equalTo(totalStackView.snp.leading)
           $0.trailing.equalTo(totalStackView.snp.trailing)
       }
       
       eyeImage.snp.makeConstraints {
           $0.width.equalTo(13)
           $0.height.equalTo(13)
       }
       
       downloadDate.snp.makeConstraints {
           $0.width.equalTo(100)
       }
       
       lowerStackView.snp.makeConstraints {
           $0.leading.equalTo(totalStackView.snp.leading)
           $0.trailing.equalTo(totalStackView.snp.trailing)
       }
    }
}

extension DetailedViewController: DetailedViewControllerProtocol {
    
    func setupView(name: String,
                   user: String,
                   description: String,
                   date: String,
                   viewsCount: String) {
        imageTitle.text = name
        usersLabel.text = user
        imageDescription.text = description
        downloadDate.text = date
        self.viewsCount.text = viewsCount
    }
    
    func setImage(data: Data) {
        DispatchQueue.main.async {
            self.selectedImage.image = UIImage(data: data)
        }
    }
}
