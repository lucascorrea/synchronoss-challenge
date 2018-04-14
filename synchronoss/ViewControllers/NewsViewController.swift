//
//  NewsViewController.swift
//  synchronoss
//
//  Created by Lucas Correa on 05/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    //
    // MARK: - Properties
    let newsViewModel = NewsViewModel()
    var isLoaded: Bool = true
    
    @IBOutlet weak var newsTableView: UITableView!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newsTableView.rowHeight = UITableViewAutomaticDimension
        self.newsTableView.estimatedRowHeight = 64
        
        loadNews(success: { _ in }, failure: { (_, _, _) in })
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !SCTwitter.isSessionValid() && !isLoaded {
            loadNews(success: { _ in }, failure: { (_, _, _) in })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // MARK: - Functions
    func loadNews(success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        Loading.show(view: UIApplication.shared.keyWindow!)
        newsViewModel.list(success: { suc in
            self.isLoaded = true
            Loading.close(view: UIApplication.shared.keyWindow!)
            self.newsTableView.reloadData()
            success(suc)
        }, failure: { (_, object, _) in
            Loading.close(view: UIApplication.shared.keyWindow!)
            failure(nil, object ,nil)
            if object as? String == "Cancel" {
                self.isLoaded = true
                delay(1, closure: {
                    self.isLoaded = false
                })
            } else {
                let alert = UIAlertController(title: "Error", message: "Error request list of news.", preferredStyle: .alert)
                alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.tweetItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsCell = (tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell)!
        newsViewModel.configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
