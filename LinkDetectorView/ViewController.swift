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
    
    fileprivate var startDate: Date = Date()
    
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MessageCell.self), for: indexPath) as! MessageCell
        cell.configure(with: messages[indexPath.row])
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.row == 0 {
            startDate = Date()
        }
        
        // boundingRect
        let height = MessageCell.heightByBoundingRect(for: messages[indexPath.row], width: view.frame.width)
        // sizeThatFits
        //        let height = MessageCell.heightBySizeThatFits(for: messages[indexPath.row], width: view.frame.width)
        
        if indexPath.row == messages.count - 1 {
            print(Date().timeIntervalSince(startDate))
        }
        return height
    }
}
