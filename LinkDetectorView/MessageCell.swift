//
//  MessageCell.swift
//  LinkDetectorView
//
//  Created by Yoshikuni Kato on 2016/06/06.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    static var dummyTextView = UITextView() {
        didSet {
            dummyTextView.textContainer.lineFragmentPadding = 0.0
            dummyTextView.textContainerInset = UIEdgeInsetsZero
            dummyTextView.showsVerticalScrollIndicator = false
            dummyTextView.showsHorizontalScrollIndicator = false
        }
    }
    
    class func height(for message: String, width: CGFloat) -> CGFloat {
        dummyTextView.font = UIFont(name: "Helvetica", size: 14.0)
        dummyTextView.text = message
        let size = dummyTextView.sizeThatFits(CGSize(width: width, height: CGFloat.max))
        return size.height
    }
    
    class func heightByBoundingRect(for message: String, width: CGFloat) -> CGFloat {
        let string = NSAttributedString(string: message, attributes:[NSFontAttributeName: UIFont(name: "Helvetica", size: 14.0)!])
        let size = string.boundingRectWithSize(CGSize(width: width, height: CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        return size.height + 1 /* magic number */
    }
    
    @IBOutlet weak var messageTextView: UITextView! {
        didSet {
            messageTextView.textContainer.lineFragmentPadding = 0.0
            messageTextView.textContainerInset = UIEdgeInsetsZero
        }
    }
    
    func configure(with message: String) {
        messageTextView.text = message
        //        updateFrame(messageTextView)
    }
    
    private func updateFrame(textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame;
    }
}
