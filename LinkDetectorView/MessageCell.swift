//
//  MessageCell.swift
//  LinkDetectorView
//
//  Created by Yoshikuni Kato on 2016/06/06.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    // MARK: static properties
    
    static let messageFont = UIFont(name: "HiraKakuProN-W6", size: 14.0)!
    
    static var dummyTextView = UITextView() {
        didSet {
            dummyTextView.textContainer.lineFragmentPadding = 0.0
            dummyTextView.textContainerInset = UIEdgeInsetsZero
            dummyTextView.showsVerticalScrollIndicator = false
            dummyTextView.showsHorizontalScrollIndicator = false
        }
    }
    
    // MARK: static methods
    class func heightBySizeThatFits(for message: String, width: CGFloat) -> CGFloat {
        dummyTextView.font = messageFont
        dummyTextView.text = message
        let size = dummyTextView.sizeThatFits(CGSize(width: 280.0, height: CGFloat.max))
        return size.height + 40.0
    }
    
    class func heightByBoundingRect(for message: String, width: CGFloat) -> CGFloat {
        let string = makeAttributedText(message)
        let options = unsafeBitCast(
            NSStringDrawingOptions.UsesLineFragmentOrigin.rawValue |
                NSStringDrawingOptions.UsesFontLeading.rawValue,
            NSStringDrawingOptions.self)
        let size = string.boundingRectWithSize(CGSize(width: 280.0, height: CGFloat.max), options: options, context: nil)
        return size.height + 10.0 /* magic number */ + 40.0 /* margin around textView*/
    }
    
    
    // MARK: properties
    @IBOutlet weak var messageTextView: UITextView! {
        didSet {
            messageTextView.textContainer.lineFragmentPadding = 0.0
            messageTextView.textContainerInset = UIEdgeInsetsZero
        }
    }
    
    
    // MARK: methods
    
    func configure(with message: String) {
        messageTextView.attributedText = MessageCell.makeAttributedText(message)
    }
    
    private class func makeAttributedText(message: String) -> NSAttributedString {
        let attrText = NSMutableAttributedString(string: message)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10.0
        attrText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: attrText.length))
        attrText.addAttributes([NSFontAttributeName: MessageCell.messageFont], range: NSRange(location: 0, length: attrText.length))
        return attrText
    }
}
