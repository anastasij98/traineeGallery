//
//  DetailedVC.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.03.23.
//

import Foundation
import UIKit
import SnapKit

class DetailedVC: UIViewController {
    
    var scrollView: UIScrollView = {
        var view = UIScrollView()
        view = UIScrollView(frame: .zero)
        view.isScrollEnabled = true
        
        return view
    }()
    
    var upperStackView: UIStackView = {
        var view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var lowerStackView: UIStackView = {
        var view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var imageTitle: UILabel = {
        var view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 20, weight: .semibold)
        view.text = "cat"
        view.numberOfLines = 0
        return view
    }()
    
    var imageDescription: UILabel = {
        var view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.text = "funny cat"
        view.numberOfLines = 0
        return view
    }()
    
    var selectedImage: UIImageView = {
        var view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "cat2")
        view.backgroundColor = .customGrey

        return view
    }()
    
    var viewsCount: UILabel = {
        var view = UILabel()
        view.textColor = .customGrey
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.text = "100"
        view.textAlignment = .right
        view.numberOfLines = 0
        return view
    }()
    
    var downloadDate: UILabel = {
        var view = UILabel()
        view.textColor = .customGrey
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.text = "10.10.2020"
        view.textAlignment = .right
        view.numberOfLines = 0
        return view
    }()
  
    var model: ItemModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
    }
    
    
     override func viewWillAppear(_ animated: Bool) {
         view.backgroundColor = .white
    }
    
   func setupScrollView() {
       upperStackView.addArrangedSubviews(imageTitle, viewsCount)
       lowerStackView.addArrangedSubviews(imageDescription, downloadDate)
       scrollView.addSubviews(selectedImage, upperStackView, lowerStackView)

       view.addSubview(scrollView)
       
       scrollView.snp.makeConstraints {
           $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
       }
       
       selectedImage.snp.makeConstraints {
           $0.top.equalToSuperview()
           $0.height.equalTo(300)
           $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
           $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
           $0.centerX.equalTo(scrollView.snp.centerX)
       }
       
       upperStackView.snp.makeConstraints {
           $0.top.equalTo(selectedImage.snp.bottom).offset(20)
           $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
           $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
       }

       lowerStackView.snp.makeConstraints {
           $0.top.equalTo(upperStackView.snp.bottom).offset(20)
           $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
           $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
       }
    }
    func setuoCellContent() {
        imageTitle.text = model?.name
        imageDescription.text = model?.description
    }
}
