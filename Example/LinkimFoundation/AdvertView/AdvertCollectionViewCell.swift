//
//  AdvertCollectionViewCell.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/7.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

let ADVERT_COLLECTION_CELL_ID = "ADVERT_COLLECTION_CELL_ID"

class AdvertCollectionViewCell: UICollectionViewCell {
    
    private var image: String?
    
    var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    init(){
        super.init(frame: CGRectZero)
        contentView.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(image:String)
    {
        self.image = image
        imageView.image = UIImage(named: image)
    }
    
}
