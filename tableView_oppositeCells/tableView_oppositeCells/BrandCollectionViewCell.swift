//
//  BrandCollectionViewCell.swift
//  tableView_oppositeCells
//
//  Created by Анатолий Кустов on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

import Foundation
import UIKit

final internal class BrandCollectionViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    let brandImg: UIImageView = {
        let brandImg = UIImageView()
        brandImg.translatesAutoresizingMaskIntoConstraints = false
        brandImg.contentMode = ContentMode.scaleAspectFit;
        brandImg.clipsToBounds = true
        return brandImg
    }()
    
    weak var delegate: BrandCollectionViewCellDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.addSubview(brandImg)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func shakeIcons() {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
        shakeAnimation.duration = 0.2
        shakeAnimation.repeatCount = 10000
        shakeAnimation.autoreverses = true
        let startAngle: Float = (-2) * 3.14159/180
        let stopAngle = -startAngle
        shakeAnimation.fromValue = NSNumber(value: startAngle as Float)
        shakeAnimation.toValue = NSNumber(value: 3 * stopAngle as Float)
        shakeAnimation.timeOffset = 290 * drand48()
        
        self.layer.add(shakeAnimation, forKey:"shakeIcons")
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            brandImg.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            brandImg.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            brandImg.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -50),
            brandImg.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: brandImg.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20)
            ])
    }
}
