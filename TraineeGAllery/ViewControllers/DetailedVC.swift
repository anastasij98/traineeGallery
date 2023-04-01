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
        view.textAlignment = .left
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
        view.image = UIImage(systemName: "eye")?.withTintColor(.customGrey, renderingMode: .alwaysOriginal)

        return view
    }()
    
    var downloadDate: UILabel = {
        var view = UILabel()
        view.textColor = .customGrey
        view.font = UIFont(name: "Roboto-Regular", size: 12)
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
  
    var model: ItemModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
        setupCellContent()

    }
  
     override func viewWillAppear(_ animated: Bool) {
         view.backgroundColor = .white
    }
    
   func setupScrollView() {
       scrollView.delegate = self
       
       upperStackView.addArrangedSubviews(imageTitle, viewsCount, eyeImage)
       lowerStackView.addArrangedSubviews(usersLabel, downloadDate)
       totalStackView.addArrangedSubviews(selectedImage, upperStackView, lowerStackView, imageDescription)
       totalStackView.setCustomSpacing(11.0, after: selectedImage)
       totalStackView.setCustomSpacing(10.0, after: upperStackView)
       totalStackView.setCustomSpacing(20.0, after: lowerStackView)

       scrollView.addSubviews(totalStackView)
       view.addSubview(scrollView)
       
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
    
    func setupCellContent() {
        imageTitle.text = model?.name
        usersLabel.text = model?.user
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
