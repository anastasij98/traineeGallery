//
//  AddPhotoViewController.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 03.05.23.
//

import Foundation
import UIKit
import SnapKit
import Photos

class AddPhotoViewController: UIViewController, UIScrollViewDelegate {
    
    var presenter: AddPhotoPresenterProtocol?
    var cellId = R.string.localization.cellIdAddPhoto()
    var addPhotoId = R.string.localization.addPhotoId()
    
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
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .galleryLightGrey
        view.addUnderLine(color: .galleryGrey)
        
        return view
    }()
    
    lazy var selectPhotoLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = R.font.robotoRegular(size: 15)
        view.textAlignment = .left
        view.text = R.string.localization.selectPhoto()
        
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: UICollectionViewFlowLayout())
        
        return view
    }()
    
    lazy var buttonView: UIView = {
        let view = UIView()
        view.snp.makeConstraints {
            $0.height.equalTo(120)
            $0.width.equalTo(120)
        }
        
        return view
    }()
    
    lazy var navigationBarButton: UIButton = {
        let view = UIButton(type: .custom) as UIButton
        view.addTarget(self,
                       action: #selector(onImagePickerTap),
                       for: .touchUpInside)
        view.setTitle(R.string.localization.allPhotos(),
                      for: UIControl.State.normal)
        view.setTitleColor(.galleryBlack, for: .normal)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupCollectionView()
        addSubviews()
        configureLayout()
        setupRightNavBarButton()
        setupCenterNavBarButton()
        presenter?.fetchAssestFromLibrary()
    }
    
    @objc
    func onNextButtonTap() {
        presenter?.onNextButtonTap()
    }
    
    @objc
    func onImagePickerTap() {
        presenter?.openImagePicker(viewController: self)
    }
    
    func setupCenterNavBarButton() {
        self.navigationItem.titleView = buttonView
        buttonView.addSubview(navigationBarButton)
        navigationBarButton.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.center.equalToSuperview()
        }
    }
    
    func setupRightNavBarButton() {
        let rightButton = UIBarButtonItem(title: R.string.localization.nextButtonTitle(),
                                          style: .plain,
                                          target: self,
                                          action: #selector(onNextButtonTap))
        rightButton.setTitleTextAttributes([.font : R.font.robotoMedium(size: 17),
                                            .foregroundColor : UIColor.galleryMain],
                                           for: .normal)
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setupScrollView() {
        view.backgroundColor = .white
        scrollView.delegate = self
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: cellId)
        collectionView.register(AddPhotoCollectionVIewCell.self,
                                forCellWithReuseIdentifier: addPhotoId)
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(imageView, selectPhotoLabel, collectionView)
    }
    
    func configureLayout() {
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
            $0.top.equalTo(stackView.snp.top)
            $0.height.equalTo(374)
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
        }
        
        selectPhotoLabel.snp.makeConstraints {
            $0.height.equalTo(42)
            $0.leading.equalTo(stackView.snp.leading)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(selectPhotoLabel.snp.bottom)
            $0.height.equalTo(150)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
    }
}

extension AddPhotoViewController: AddPhotoVCProtocol {
    
    func setSelectedObject(model: ImageObjectModel) {
        imageView.image = model.image
    }
}

extension AddPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = originalImage
            if let data = originalImage.jpegData(compressionQuality: 1) {
                print(data)
                presenter?.selectedObject(object: data)
            }
        }
        dismiss(animated: true)
    }
    
    func setupImageView(image: Data) {
        imageView.image = UIImage(data: image)
    }
}
