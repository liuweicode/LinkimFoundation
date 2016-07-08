//
//  UIimageViewViewController.swift
//  LinkimFoundation
//
//  Created by Vic on 16/7/5.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import AlamofireImage

class UIimageViewViewController: UIViewController {
    
    let imgUrl = "http://a.hiphotos.baidu.com/baike/pic/item/738b4710b912c8fc63b8eb8cfd039245d6882123.jpg"
    
    let imgView : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor.clearColor()
        img.contentMode = .ScaleAspectFit
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubView()
        
        // Do any additional setup after loading the view.
    }
    
    func initSubView() {
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(imgView)
        imgView.snp_makeConstraints { (make) in
            make.top.equalTo(view.snp_top).offset(50)
            make.left.equalTo(view.snp_left).offset(30)
            make.right.equalTo(view.snp_right).offset(-30)
            make.height.equalTo(imgView.snp_width).multipliedBy(1.5)
        }
        if let url = NSURL(string: imgUrl)
        {
            imgView.cacheWith(url, placeholderImage: UIImage(named: "defalut_image"), imageTransition: .CurlDown(0.2))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
