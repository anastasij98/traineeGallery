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
    
    /// Установка информации о выбранной картинке в галерее
    /// - Parameters:
    ///   - name: имя картинки
    ///   - user: имя пользователя
    ///   - description: описание картинки
    ///   - date: дата добавления картинки
    func setupView(name: String,
                   user: String,
                   description: String,
                   date: String)
    
    /// Установка изображения выбранной картинке в галерее
    /// - Parameter data: картинка в виде Data
    func setImage(data: Data)
}

class DetailedViewController: UIViewController {
    
    var presenter: DetailedPresenterProtocol?
    
    var scrollView: UIScrollView = {
        var view = UIScrollView()
        view = UIScrollView(frame: .zero)
        view.isScrollEnabled = true
        view.scrollsToTop = false
        view.minimumZoomScale = 1
        view.maximumZoomScale = 10
        
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
        view.backgroundColor = .galleryGrey

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
        view.textColor = .galleryGrey
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
    
    var downloadDate: UILabel = {
        var view = UILabel()
        view.textColor = .galleryGrey
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
        
        setupNavigationBar(backButtonTitle: "Back")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        //        checkOrientationAndSetLayout()
    }
    
    func checkOrientationAndSetLayout() {
        if UIDevice.current.orientation.isLandscape {
            totalStackView.snp.remakeConstraints {
                $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(180)
                $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
                $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
                $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
            }
            
            selectedImage.snp.remakeConstraints {
                $0.height.equalTo(180)
                $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
                $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            }
        } else {
            totalStackView.snp.remakeConstraints {
                $0.top.equalTo(scrollView.contentLayoutGuide.snp.top).offset(251)
                $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
                $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
                $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)

            }
            
            selectedImage.snp.remakeConstraints {
                $0.height.equalTo(251)
                $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
                $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            }
        }
    }
    
    func setupScrollView() {
        view.backgroundColor = .white
        scrollView.delegate = self
//        scrollView.contentSize = view.safeAreaLayoutGuide.layoutFrame.size
        
        view.addSubview(scrollView)
//        scrollView.addSubviews(totalStackView, selectedImage)
        scrollView.addSubview(totalStackView)
        upperStackView.addArrangedSubviews(imageTitle)
        lowerStackView.addArrangedSubviews(usersLabel, downloadDate)
//        totalStackView.addArrangedSubviews(upperStackView, lowerStackView, imageDescription)
        totalStackView.addArrangedSubviews(selectedImage ,upperStackView, lowerStackView, imageDescription)
        
        totalStackView.setCustomSpacing(10.0, after: selectedImage)
        totalStackView.setCustomSpacing(10.0, after: upperStackView)
        totalStackView.setCustomSpacing(20.0, after: lowerStackView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        selectedImage.snp.makeConstraints {
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            $0.height.equalTo(251)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
        
        totalStackView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(251)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
        }
        
        upperStackView.snp.makeConstraints {
            $0.leading.equalTo(totalStackView.snp.leading)
            $0.trailing.equalTo(totalStackView.snp.trailing)
        }
        
        imageDescription.snp.makeConstraints {
            $0.leading.equalTo(totalStackView.snp.leading)
            $0.trailing.equalTo(totalStackView.snp.trailing)
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
//MARK: - DetailedViewControllerProtocol
extension DetailedViewController: DetailedViewControllerProtocol {
    
    func setupView(name: String,
                   user: String,
                   description: String,
                   date: String) {
        imageTitle.text = name
        usersLabel.text = user
        imageDescription.text = description
        downloadDate.text = date
    }
    
    func setImage(data: Data) {
        DispatchQueue.main.async {
            self.selectedImage.image = UIImage(data: data)
        }
    }
}
//MARK: - UIScrollViewDelegate
extension DetailedViewController: UIScrollViewDelegate  {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        selectedImage
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
//        selectedImage.transform = CGAffineTransform.identity
        scrollView.setZoomScale(1.0, animated: true)
    }
}
