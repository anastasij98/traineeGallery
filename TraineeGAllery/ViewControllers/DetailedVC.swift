//
//  DetailedVC.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.03.23.
//

import Foundation
import UIKit
import SnapKit

class DetailedVC: UIViewController, UIScrollViewDelegate {
    
    var dataTask: URLSessionDataTask?

    var scrollView: UIScrollView = {
        var view = UIScrollView()
        view = UIScrollView(frame: .zero)
        view.isScrollEnabled = true
        view.scrollsToTop = false

        return view
    }()
    
    var upperStackView: UIStackView = {
        var view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()

    var lowerStackView: UIStackView = {
        var view = UIStackView()
        view.axis = .horizontal
        view.alignment = .top
        view.distribution = .equalSpacing

        return view
    }()
    
    var selectedImage: UIImageView = {
        var view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .customGrey

        return view
    }()
    
    var imageTitle: UILabel = {
        var view = UILabel()
        view.textColor = .black
        view.font = UIFont(name: "Roboto-Regular", size: 20)
        view.numberOfLines = 0
        return view
    }()
    
    var usersLabel: UILabel = {
        var view = UILabel()
        view.textColor = .customGrey
        view.font = UIFont(name: "Roboto-Regular", size: 15)
        view.textAlignment = .right
        return view
    }()
    
    var imageDescription: UILabel = {
        var view = UILabel()
        view.textColor = .black
        view.font = UIFont(name: "Roboto-Light", size: 15)
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 0
        view.textAlignment = .justified
        return view
    }()
    
    var viewsCount: UILabel = {
        var view = UILabel()
        view.textColor = .customGrey
        view.font = UIFont(name: "Roboto-Regular", size: 12)
        view.textAlignment = .right
        view.numberOfLines = 0
        return view
    }()
    
    var eyeImage: UIImageView = {
        var view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .customGrey
        view.image = UIImage(named: "Mask")
        view.image?.withTintColor(.customGrey)

        return view
    }()
    
    var downloadDate: UILabel = {
        var view = UILabel()
        view.textColor = .customGrey
        view.font = UIFont(name: "Roboto-Regular", size: 12)
        view.textAlignment = .right
        view.numberOfLines = 0
        return view
    }()
  
    var model: ItemModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
        setupCellContent()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let contentHeight = upperStackView.frame.height + lowerStackView.frame.height + imageDescription.frame.height + selectedImage.frame.height
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: contentHeight)
//        print(scrollView.frame.height)
//        print(contentHeight)
    }
  
     override func viewWillAppear(_ animated: Bool) {
         view.backgroundColor = .white
    }
    
   func setupScrollView() {
       scrollView.delegate = self
       
       upperStackView.addArrangedSubviews(imageTitle, viewsCount)
       lowerStackView.addArrangedSubviews(usersLabel, downloadDate)
       scrollView.addSubviews(selectedImage, upperStackView, eyeImage, lowerStackView, imageDescription)

       view.addSubview(scrollView)
       
       scrollView.snp.makeConstraints {
           $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
       }
       
       selectedImage.snp.makeConstraints {
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            $0.height.equalTo(251)
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            $0.centerX.equalTo(scrollView.snp.centerX)
        }
       
       upperStackView.snp.makeConstraints {
           $0.top.equalTo(selectedImage.snp.bottom).offset(20)
           $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading).offset(20)
           $0.trailing.equalTo(eyeImage.snp.trailing).inset(20)
       }

       eyeImage.snp.makeConstraints {
           $0.leading.equalTo(upperStackView.snp.trailing).offset(4)
           $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing).inset(20)
           $0.centerY.equalTo(upperStackView.snp.centerY)
       }
      
       lowerStackView.snp.makeConstraints {
           $0.top.equalTo(upperStackView.snp.bottom).offset(20)
           $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading).offset(20)
           $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing).inset(20)
       }
       
       imageDescription.snp.makeConstraints {
           $0.top.equalTo(lowerStackView.snp.bottom).offset(20)
           $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading).offset(20)
           $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing).inset(20)
       }
      
    }
    
    func setupCellContent() {
        imageTitle.text = model?.name
        usersLabel.text = model?.name
        imageDescription.text = model?.description
        selectedImage.image = UIImage(named: (model?.image.name) ?? "cat2")
        downloadDate.text = model?.date
        
        guard let id = model?.id else {return}
        viewsCount.text = "\(id)"

        if let name = model?.image.name {
            let urlString = URLConfiguration.url + URLConfiguration.media + name
            guard let url = URL(string: urlString) else {
                return
            }
            
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.selectedImage.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
            dataTask = task
        }
    }
    
    deinit {
        dataTask?.cancel()
    }
}
