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
            dummyTextView.textContainerInset = UIEdgeInsets.zero
            dummyTextView.showsVerticalScrollIndicator = false
            dummyTextView.showsHorizontalScrollIndicator = false
        }
    }
    
    // MARK: static methods
    class func heightBySizeThatFits(for message: String, width: CGFloat) -> CGFloat {
        dummyTextView.font = messageFont
        dummyTextView.text = message
        let size = dummyTextView.sizeThatFits(CGSize(width: 280.0, height: CGFloat.greatestFiniteMagnitude))
        return size.height + 40.0
    }
    
    class func heightByBoundingRect(for message: String, width: CGFloat) -> CGFloat {
        let string = makeAttributedText(message)
        let options = unsafeBitCast(
            NSStringDrawingOptions.usesLineFragmentOrigin.rawValue |
                NSStringDrawingOptions.usesFontLeading.rawValue,
            to: NSStringDrawingOptions.self)
        let size = string.boundingRect(with: CGSize(width: 280.0, height: CGFloat.greatestFiniteMagnitude), options: options, context: nil)
        return size.height + 10.0 /* magic number */ + 40.0 /* margin around textView*/
    }
    
    
    // MARK: properties
    @IBOutlet weak var messageTextView: UITextView! {
        didSet {
            messageTextView.textContainer.lineFragmentPadding = 0.0
            messageTextView.textContainerInset = UIEdgeInsets.zero
        }
    }
    
    
    // MARK: methods
    
    func configure(with message: String) {
        messageTextView.attributedText = MessageCell.makeAttributedText(message)
    }
    
    fileprivate class func makeAttributedText(_ message: String) -> NSAttributedString {
        let attrText = NSMutableAttributedString(string: message)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10.0
        attrText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: attrText.length))
        attrText.addAttributes([NSFontAttributeName: MessageCell.messageFont], range: NSRange(location: 0, length: attrText.length))
        return attrText
    }
}
