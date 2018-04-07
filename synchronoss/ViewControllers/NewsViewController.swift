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
    
    @IBOutlet weak var newsTableView: UITableView!
    
    //
    // MARK: - Cycle life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newsTableView.rowHeight = UITableViewAutomaticDimension
        self.newsTableView.estimatedRowHeight = 64
        
        Loading.show(view: UIApplication.shared.keyWindow!)
        newsViewModel.list(success: { _ in
            Loading.close(view: UIApplication.shared.keyWindow!)
            self.newsTableView.reloadData()
        }, failure: { (_, _, _) in
            let alert = UIAlertController(title: "Error", message: "Error request list of news.", preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            Loading.close(view: UIApplication.shared.keyWindow!)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.tweetItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: NewsCell = (tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell)!
        newsViewModel.configureCell(cell: &cell, indexPath: indexPath)
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
