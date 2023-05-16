//
//  SegmentedControlUnderLine.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 31.03.23.
//

import Foundation
import UIKit
import SnapKit

class SplitUnderlineView: UIView {
    
    private lazy var arrayOfViews: [UIView] = .init()
    
    private lazy var stackView: UIStackView = {
        // горизонтальный стек, растягивающий контент по своей ширине
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        
        return view
    }()
    
    
    func setup(underlinesCount: Int) {
        // очищенеие массива и стека
        arrayOfViews.removeAll()
        stackView.arrangedSubviews.forEach { view in
            stackView.removeArrangedSubview(view)
        }
        // добавление в массив столько вьюх, сколько прилетело в параметрах и задание высоты в 1-2 пикселя по дизайну
        for _ in 1...underlinesCount {
            let view = UIView()
            view.backgroundColor = .clear
            view.snp.makeConstraints {
                $0.height.equalTo(2)
            }
            arrayOfViews.append(view)
        }
        // добавление массива в стеквью
        stackView.addArrangedSubviews(arrayOfViews)
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setHighlited(viewWithindex index: Int) {
        // перекрашивание всех вьюх в массиве в неактивный цвет и одного(с указанным индексом) в активный цвет
        arrayOfViews.enumerated().forEach { offset, element in
            element.backgroundColor = offset == index ? .black : .clear
        }
    }
}

extension UIImage {
    
    class func getSegmentedControlRectangle(color: CGColor, andSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        context?.fill(rectangle)
        
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}

extension UISegmentedControl {
    
    func removeBorder() {
        let background = UIImage.getSegmentedControlRectangle(color: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor, andSize: self.bounds.size)
        // segment background color and size
        self.setBackgroundImage(background, for: .normal, barMetrics: .default)
        self.setBackgroundImage(background, for: .selected, barMetrics: .default)
        self.setBackgroundImage(background, for: .highlighted, barMetrics: .default)
        
        let deviderLine = UIImage.getSegmentedControlRectangle(color: UIColor.white.cgColor, andSize: CGSize(width: 1.0, height: 5))
        self.setDividerImage(deviderLine, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([.foregroundColor: UIColor.mainGrey,
                                     .font: UIFont.systemFont(ofSize: 17, weight: .regular)], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                     .font: UIFont.systemFont(ofSize: 17, weight: .regular)], for: .selected)
    }
}
