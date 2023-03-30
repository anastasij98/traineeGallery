//
//  CollectionViewCellMode.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.03.23.
//

import Foundation
import UIKit
import SnapKit
import Alamofire

struct CollectionViewCellModel {
    var imageURL: URL?
}

class CollectionViewCell: UICollectionViewCell {
    
    var imageInGallery: UIImageView = UIImageView()
    var request: Alamofire.Request?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImage()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
        imageInGallery.contentMode = .scaleAspectFit
    }
    
    func setupCollectionItem(model: CollectionViewCellModel) {
        let url = model.imageURL
        let requestAF = url?.absoluteString
        
        request = AF.request(requestAF!, method: .get).responseData { response in
            if let data = response.data {
                DispatchQueue.main.async {
                    self.imageInGallery.image = UIImage(data: data)
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageInGallery.image = nil
        request?.cancel()
        request = nil
    }
    
    
}
