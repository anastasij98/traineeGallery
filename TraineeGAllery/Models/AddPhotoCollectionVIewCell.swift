//
//  AddPhotoCollectionVIewCell.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 10.05.23.
//
import Foundation
import UIKit
import SnapKit
import Kingfisher

struct ImageObjectModel {
    
    let imageName: String
    
    var image: UIImage? {
        UIImage(named: imageName)
    }
}

class AddPhotoCollectionVIewCell: UICollectionViewCell {
    
    var currentImageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupImage(model: ImageObjectModel) {
        if currentImageView.superview == nil {
            contentView.addSubview(currentImageView)
            
            currentImageView.snp.makeConstraints({
                $0.edges.equalTo(contentView.snp.edges)
            })
        }
        
        currentImageView.contentMode = .scaleAspectFill
        currentImageView.clipsToBounds = true
        currentImageView.image = model.image
    }
}
