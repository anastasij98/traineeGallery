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
//        view.contentSize = CGSize(width: 400, height: 2300)
        view.contentSize = CGSize(width: view.contentSize.width, height: view.contentSize.height)
        view.isUserInteractionEnabled = true


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
        view.font = .systemFont(ofSize: 20, weight: .semibold)
        view.numberOfLines = 0
        return view
    }()
    
    var imageDescription: UILabel = {
        var view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.numberOfLines = 0
        return view
    }()

    
    var viewsCount: UILabel = {
        var view = UILabel()
        view.textColor = .customGrey
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textAlignment = .right
        view.numberOfLines = 0
        return view
    }()
    
    var downloadDate: UILabel = {
        var view = UILabel()
        view.textColor = .customGrey
        view.font = .systemFont(ofSize: 12, weight: .regular)
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
    
    
     override func viewWillAppear(_ animated: Bool) {
         view.backgroundColor = .white
    }
    
   func setupScrollView() {
       scrollView.delegate = self
       
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
    func setupCellContent() {
        imageTitle.text = model?.name
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
