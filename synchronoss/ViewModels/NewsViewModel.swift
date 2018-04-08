//
//  NewsViewModel.swift
//  synchronoss
//
//  Created by Lucas Correa on 07/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import Foundation
import UIKit

class NewsViewModel {
    
    //
    // MARK: - Properties
    var tweetItems: [Tweet]
    
    //
    // MARK: - Initializer
    init() {
        tweetItems = [Tweet]()
    }
    
    //
    // MARK: - Public Functions
    func list(success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        if SCTwitter.isSessionValid() {
            self.loadUserTimeline(success: success)
        } else {
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                Loading.close(view: UIApplication.shared.keyWindow!)
                SCTwitter.loginViewControler(topController, callback: { (successTwitter, _) in
                    if successTwitter {
                        self.loadUserTimeline(success: success)
                    } else {
                        failure(nil, "Cancel" as AnyObject, nil)
                    }
                })
            }
        }
    }
    
    // Configure Cell
    func configureCell(cell: inout NewsCell, indexPath: IndexPath) {
        let tweet = tweetItems[indexPath.row]
        cell.detailText.text = tweet.text
        cell.screenNameLabel.text = tweet.user.screenName
        let dateFormatter = Global.dateFormatter
        dateFormatter.dateFormat = "E MMM dd HH:mm:ss +0000 yyyy"
        let date = dateFormatter.date(from: tweet.time)
        
        dateFormatter.dateFormat = "dd MMM HH:mm"
        let dateString = dateFormatter.string(from: date!)
        cell.timeLabel.text = dateString
    }
    
    // Get List of tweets of IrishRail
    fileprivate func loadUserTimeline(success: @escaping SuccessHandler) {
        SCTwitter.getUserTimeline(for: "IrishRail", sinceID: 0, startingAtPage: 0, count: 200) { (successTwitter, result) in
            if successTwitter {
                do {
                    let data = try JSONSerialization.data(withJSONObject: result as Any, options: .prettyPrinted)
                    
                    let tweets = try JSONDecoder().decode([Tweet].self, from: data)
                    self.tweetItems = tweets
                    success(tweets as AnyObject)
                } catch let err {
                    print(err)
                }
            }
        }
    }
}
