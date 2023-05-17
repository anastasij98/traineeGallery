//
//  CollectionViewCellMode.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.03.23.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

struct CollectionViewCellModel {
    
    var imageURL: URL?
}

class MainCollectionViewCell: UICollectionViewCell {
    
    var imageInGallery: UIImageView = UIImageView()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImage()
        setupCell()
        setupActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageInGallery.image = nil
        imageInGallery.kf.cancelDownloadTask()
    }
    
    func setupActivityIndicator() {
        contentView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(30)
        }
    }
    
    func setupCell() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    func setupImage() {
        contentView.addSubview(imageInGallery)
        
        imageInGallery.snp.makeConstraints({
            $0.edges.equalTo(contentView.snp.edges)
        })
        
        imageInGallery.contentMode = .scaleAspectFill
    }
    
    func setupCollectionItem(model: CollectionViewCellModel) {
        let url = model.imageURL
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        imageInGallery.kf.setImage(with: url, options: [.transition(.fade(0.2))]) { [ weak self ] _ in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
        }
    }
}
