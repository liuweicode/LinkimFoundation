//
//  PlaceholderTextView.swift
//  LinkimFoundation
//
//  Created by 刘伟 on 16/7/11.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import LinkimFoundation

class PlaceholderTextView: UITextView {

    private var _placeholder:String?
    
    private var _placeholderColor:UIColor?
    
    var placeholderLabel:UILabel = {
        let placeholderLabel = UILabel()
        return placeholderLabel
    }()
    
    var placeholder:String?{
        get{
            return self._placeholder
        }
        set{
            self._placeholder = newValue
            self.setNeedsDisplay()
        }
    }

    var placeholderColor:UIColor{
        get{
            return self._placeholderColor ?? UIColor.lightGrayColor()
        }
        set{
            self._placeholderColor = newValue
            self.setNeedsDisplay()
        }
    }
    
    override var font: UIFont?{
        get{
            return super.font
        }
        set{
            super.font = newValue
            self.setNeedsDisplay()
        }
    }
    
    override var text: String!{
        get{
            return super.text
        }
        set{
            super.text = newValue
            self.setNeedsDisplay()
        }
    }
    
    init()
    {
        super.init(frame: CGRectZero, textContainer:nil)
        self.setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup()
    {
        self.placeholderColor = UIColor.lightGrayColor()
        self.addSubview(self.placeholderLabel)
        self.placeholderLabel.hidden = true
        
        self.registerNotification(name: UITextViewTextDidChangeNotification, selector: #selector(textViewTextDidChange(_:)))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        if let placeholder = self.placeholder where self.text.length == 0{
            if self.font == nil{
                self.font = UIFont.systemFontOfSize(12)
            }
            let attrString = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName:self.placeholderColor, NSFontAttributeName:self.font!])
            self.placeholderLabel.attributedText = attrString
            self.placeholderLabel.sizeToFit()
            let placeholderRect = self.placeholderLabel.frame
            self.placeholderLabel.frame = CGRect(x: 4, y: 8, width: placeholderRect.size.width, height: placeholderRect.size.height)
            self.placeholderLabel.hidden = false
        }else{
            self.placeholderLabel.hidden = true
        }
    }
    
    deinit{
        self.unRegisterAllNotification()
    }
    
    func textViewTextDidChange(note:NSNotification)
    {
        self.setNeedsDisplay()
    }
    
}
