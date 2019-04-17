//
//  BrandsViewController.swift
//  tableView_oppositeCells
//
//  Created by Анатолий Кустов on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

import Foundation
import UIKit

open class BrandsViewController: UIViewController {
    
    let layout = BrandCollectionViewLayout()
    
    fileprivate lazy var collectionView: UICollectionView = {
        layout.delegate = self
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.init(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1);
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.register(BrandCollectionViewCell.self, forCellWithReuseIdentifier: "BrandCell")
        return collectionView
    }()
    
    
    fileprivate lazy var dataSource: [BrandObjectCollection] = [
        BrandObjectCollection(label: "Adidas", image: resizeImage(image: UIImage(named: "adidas")!, targetSize: CGSize(width: 300, height: 300))),
        BrandObjectCollection(label: "Nike", image: resizeImage(image: UIImage(named: "nike")!, targetSize: CGSize(width: 300, height: 300.0))),
        BrandObjectCollection(label: "NewBalance", image: resizeImage(image: UIImage(named: "newbalance")!, targetSize: CGSize(width: 300, height: 300.0))),
        BrandObjectCollection(label: "cK", image: resizeImage(image: UIImage(named: "ck")!, targetSize: CGSize(width: 150.0, height: 150.0))),
        BrandObjectCollection(label: "Reebok", image: resizeImage(image: UIImage(named: "reebok")!, targetSize: CGSize(width: 300, height: 300.0))),
    ]
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        view.addSubview(collectionView)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        layout.invalidateLayout()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.frame
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

extension BrandsViewController: UICollectionViewDataSource {
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as? BrandCollectionViewCell {
            cell.titleLabel.text = dataSource[indexPath.row].label
            cell.backgroundColor = UIColor.init(red: 192.0/255.0, green: 192.0/255.0, blue: 192.0/255.0, alpha: 0.8)
            cell.brandImg.image = dataSource[indexPath.row].image
            cell.delegate = self
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 6
            cell.shakeIcons()
            return cell
        }
        return UICollectionViewCell()
    }
    

}


extension BrandsViewController: BrandCollectionViewCellDelegate {
    func didTap(cell: BrandCollectionViewCell) {
        let alertController = UIAlertController(title: "Bang", message: cell.titleLabel.text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension BrandsViewController: BrandCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return dataSource[indexPath.item].image.size.height
    }
}
