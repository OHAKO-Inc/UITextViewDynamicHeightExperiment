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
    
    lazy var messages: [String] = {
        
        let letters = "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをんっゃゅょabcdefghijklmnopqrstuvwxyz0123456789-「」"
        let messageLength = GKRandomDistribution(lowestValue: 1, highestValue: 500)
        let letterIndex = GKRandomDistribution(lowestValue: 1, highestValue: letters.characters.count - 1)

        var messages = [String]()
        for line in 0...999 {
            var message = "http://google.com y.kato@ohako-inc.jp "
            
            for i in 0...messageLength.nextInt() {
                let index = letterIndex.nextInt()
                message += letters[index]
            }
            message += "🍎"
            messages.append(message)
        }
        
        return messages
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        tableView.rowHeight = UITableViewAutomaticDimension
    }

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
        let height = MessageCell.heightByBoundingRect(for: messages[indexPath.row], width: view.frame.width)
        print(height)
        return height
    }
    //    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }
}