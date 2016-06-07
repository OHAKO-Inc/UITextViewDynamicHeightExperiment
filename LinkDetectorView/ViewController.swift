//
//  ViewController.swift
//  LinkDetectorView
//
//  Created by Yoshikuni Kato on 2016/06/06.
//  Copyright © 2016年 Ohako Inc. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var startDate: NSDate = NSDate()
    
    lazy var messages: [String] = {
        
        let letters = "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをんっゃゅょabcdefghijklmnopqrstuvwxyz0123456789-「」"
        let messageLength = GKRandomDistribution(lowestValue: 1, highestValue: 500)
        let letterIndex = GKRandomDistribution(lowestValue: 1, highestValue: letters.characters.count - 1)

        var messages = [String]()
        for line in 0...999 {
            var message = ""
            
            for i in 0...messageLength.nextInt() {
                let index = letterIndex.nextInt()
                message += letters[index]
                if i % 100 == 0 {
                    message += " http://google.com "
                }
                if i % 200 == 0 {
                    message += " y.kato@ohako-inc.jp "
                }
            }
            message += "gjqyp🍎"
            messages.append(message)
        }
        
        return messages
        
    }()

}

extension ViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(MessageCell), forIndexPath: indexPath) as! MessageCell
        cell.configure(with: messages[indexPath.row])
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        if indexPath.row == 0 {
            startDate = NSDate()
        }
        
        // boundingRect
        let height = MessageCell.heightByBoundingRect(for: messages[indexPath.row], width: view.frame.width)
        // sizeThatFits
        //        let height = MessageCell.heightBySizeThatFits(for: messages[indexPath.row], width: view.frame.width)
        
        if indexPath.row == messages.count - 1 {
            print(NSDate().timeIntervalSinceDate(startDate))
        }
        return height
    }
}